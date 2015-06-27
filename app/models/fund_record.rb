class FundRecord < ActiveRecord::Base
  attr_accessible :d1, :d10, :d11, :d12, :d2, :d3, :d4, :d5, :d6, :d7, :d8, :d9, :fund_name, :fund_size, :isin, :sector, :wd12, :wd26, :wd4, :wr12, :wr26, :wr4, :creation_date, :fund_id, :file_stat_id, :continent_id, :country_id, :time_point_id, :region_id

  #region id is the sector_id need to move this accross

    belongs_to :fund
    belongs_to :file_stat


    def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |fund_record|
        csv << fund_record.attributes.values_at(*column_names)
      end
    end
  end


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

  def self.check_creation_date(file)
       reader = file
       creation_date = get_create_date(reader)
       FileStat.where(creation_date: creation_date).exists?
  end



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

        read(columns, reader, creation_date)
    
     puts columns
     true
   else
    false
  end

  end

  def self.get_create_date(file)
    reader = file
    info_hash = reader.info
    creation_date = info_hash[:CreationDate][2..9]
  end


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

    def self.search_country(search_string)
      if Country.where(name: search_string).exists?
        return Country.where(name: search_string)
      else
        return "none"
      end
    end

    


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
        if a != "none"

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

            if !r[i]["fund_size"].nil?
              fs = r[i]["fund_size"]
              if fs[0] == "£"
                fs.delete!("£,")
                r[i]["fund_size"] = fs
              end
            end

            unless Fund.where(name: r[i]["fund_name"]).exists?
              fund_details = {}
              fund_country = []
              fund_country << find_country(r[i]["fund_name"])

              puts r[i]["fund_name"]
              puts fund_country

              if fund_country[0][0] == "none"
                fund_country=[]

                fund_country << find_country(r[i]["sector"])

                if fund_country[0][0] == "none"

                  fund_details["country"] = "none"
                  fund_details["continent"] = "none"
                else
                  fund_details["country"] = fund_country[0][0]
                  fund_details["continent"] = fund_country[0][1]
                end

              else
                fund_details["country"] = fund_country[0][0]
                fund_details["continent"] = fund_country[0][1]
              end


              if r[i]["isin"].nil?
                Fund.create(name: r[i]["fund_name"], sector: r[i]["sector"], country: fund_details["country"] , continent:fund_details["continent"] )
              else
                Fund.create(name: r[i]["fund_name"], sector: r[i]["sector"],country: fund_details["country"] , continent: fund_details["continent"], isin: r[i]["isin"].strip)
              end

            else
              fund_to_check = Fund.where(name: r[i]["fund_name"])
              if fund_to_check[0].isin.empty?
                fund_to_check[0].isin = r[i]["isin"].strip
                fund_to_check[0].save
              end
            end
            unless FundRecord.where(fund_name: r[i]["fund_name"], creation_date: r[i]["creation_date"] ).exists?
              FundRecord.create(r[i])
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
     FileStat.create(column_size: columns.size, creation_date: creation_date, records: i, time_to_load: c)
  end

end
