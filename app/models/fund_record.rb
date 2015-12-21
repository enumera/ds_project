class FundRecord < ActiveRecord::Base
  attr_accessible :d1, :d10, :d11, :d12, :d2, :d3, :d4, :d5, :d6, :d7, :d8, :d9, :fund_name, :fund_size, :isin, :sector, :wd12, :wd26, :wd4, :wr12, :wr26, :wr4, :creation_date, :fund_id, :file_stat_id, :continent_id, :country_id, :time_point_id, :region_id, :next_wd_four

  #region id is the sector_id need to move this accross

    belongs_to :fund
    belongs_to :file_stat

    # download the fund records

    def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |fund_record|
        csv << fund_record.attributes.values_at(*column_names)
      end
    end
  end

  # find the number of records in the pdf

   def self.find_max(pdf_reader)
      reader = pdf_reader
      i = 0
      j = 0 
      a = Time.now
      puts a

      reader.pages.each do |page|
        if j == 1
          page.text.split("\n").each do |line|
            if line.scan(/\s{2}+/).size > i
              i = line.scan(/\s{2}+/).size
              puts "line size is #{line.scan(/\s{2}+/).size}"
            end
          end
        end
        j=1
      end
      return i
  end

  # check if the file has already been added

  def self.check_creation_date(file)
       reader = file
       creation_date = get_create_date(reader)
       FileStat.where(creation_date: creation_date).exists?
  end

  # import script for the pdf

  def self.import(file)
    reader = PDF::Reader.new(file.tempfile.path)

    unless check_creation_date(reader)

      creation_date = get_create_date(reader)
        max = find_max(reader)

        if max > 13
            columns = find_columns(max+1)
          else
            columns = find_columns(max)
        end

        # send to the read the pdf

        read(columns, reader, creation_date)
    
     puts columns
     true
   else
    false
  end

  end

  # get the creation date

  def self.get_create_date(file)
    reader = file
    info_hash = reader.info
    creation_date = info_hash[:CreationDate][2..9]
    year = creation_date[0..3]
    month = creation_date[4..5]
    day = creation_date[6..7]
    actual_creation_date = Date.parse("#{year}-#{month}-#{day}")
  end

  # for the history of the record set from saltydog the columns have changed

  def self.find_columns(max)
    case max.to_i
      when 13
        c = ["sector", "fund_name", "d1","d2", "d3","d4", "d5","d6", "d7","d8",  "wr4","wr12", "wr26"]
      when 15
        c = ["sector", "fund_name","wd4", "d1","d2", "d3","d4", "d5","d6", "d7","d8","wr4","wr12", "wr26", "isin"]
      when 21
        c = ["sector", "fund_name", "wd4", "wd12", "wd26", "wr4","wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "isin"]
      when 22
        c = ["sector", "fund_name", "wd4", "wd12", "wd26", "wr4", "wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "fund_size", "isin"]
    end
  end

  # search for the country

    def self.search_country(search_string)
      if Country.where(alias: search_string).exists?
        return Country.where(alias: search_string)
      else
        return "none"
      end
    end

    
    # split the fund name and search for countries when found allocate the country and continent

    def self.find_country(fund_name_string)
      search_array = []
      search_array = fund_name_string.split(" ")

      search_array.each do |word|
        word.delete!(".")
        word.delete!(",")
      end

      country = []
      search_array.each do |fund_split|
          a = search_country(fund_split)
          unless a == "none"
            country << a[0]["alias"]
            country << a[0]["region"]
          end
      end
      if country.empty?
        country << "none"
      end
      return country
    end



  def self.read(columns, pdf_file, creation_date)
      
      file_stat_record = FileStat.create(column_size: columns.size, creation_date: creation_date)
      r = {}
      reader = pdf_file
      i = 0
      a = Time.now
      puts a
      reader.pages.each do |page|
        page.text.split("\n").each do |line|
          if line.scan(/\s{2}+/).size == columns.size - 1
            r[i] = Hash[columns.zip(line.gsub(/\s{2}+/m, '#').strip.split("#"))]
            
            r[i]["creation_date"] = creation_date


            # if there is a fund size then add it

            if !r[i]["fund_size"].nil?
              fs = r[i]["fund_size"]
              if fs[0] == "£"
                fs.delete!("£,")
                r[i]["fund_size"] = fs
              end
            end

            # if the fund doesn't exit create it

            unless Fund.where(name: r[i]["fund_name"]).exists?
              fund_details = {}
              fund_country = []

              # find the country in which the fund invests

              fund_country << find_country(r[i]["fund_name"])

              puts r[i]["fund_name"]
              puts fund_country

              # if the fund country is not in the name then allocate the sector

              if fund_country[0][0] == "none"
                fund_country=[]

                fund_country << find_country(r[i]["sector"])

                # if the fund country is none then allocate the fund details and continent as none

                if fund_country[0][0] == "none"

                  fund_details["country"] = "none"
                  fund_details["continent"] = "none"
                else
                  fund_details["country"] = fund_country[0][0]
                  fund_details["continent"] = fund_country[0][1]
                end
                # if the fund already exits then add the fund country to the fund_details
              else
                fund_details["country"] = fund_country[0][0]
                fund_details["continent"] = fund_country[0][1]
              end


              if r[i]["isin"].nil?
                f = Fund.create(name: r[i]["fund_name"], sector: r[i]["sector"], country_name: fund_details["country"] , continent:fund_details["continent"] )

                c = Country.find_by_alias(f.country_name)

                f.country = c


              else
                f = Fund.create(name: r[i]["fund_name"], sector: r[i]["sector"],country_name: fund_details["country"] , continent: fund_details["continent"], isin: r[i]["isin"].strip)
              
                 c = Country.find_by_alias(f.country_name)

                 f.country = c
              end

            else
              fund_to_check = Fund.where(name: r[i]["fund_name"])
              if fund_to_check[0].isin.empty?
                fund_to_check[0].isin = r[i]["isin"].strip
                fund_to_check[0].save
              end
            end
            unless FundRecord.where(fund_name: r[i]["fund_name"], creation_date: r[i]["creation_date"] ).exists?
              
              fund = Fund.find_by_name(r[i]["fund_name"])
              r[i]["fund_id"] = fund.id
              r[i]["file_stat_id"] = file_stat_record.id
              # binding.pry
              FundRecord.create(r[i])
              # binding.pry
            end
            i += 1
          end
        end
      end
      # puts "number of records added #{i}"
      # puts r[i-1]
     # puts "Column size #{columns.size} "
     b = Time.now
     c = b -a
     puts c
     # binding.pry
     # FileStat.create(column_size: columns.size, creation_date: creation_date, records: i, time_to_load: c)
     file_stat_record.records = i
     file_stat_record.time_to_load = c
     file_stat_record.save
  end

end
