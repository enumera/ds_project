class FundRecord < ActiveRecord::Base
  attr_accessible :d1, :d10, :d11, :d12, :d2, :d3, :d4, :d5, :d6, :d7, :d8, :d9, :fund, :fund_size, :isin, :sector, :wd12, :wd26, :wd4, :wr12, :wr26, :wr4, :creation_date

# c1 = ["sector", "fund", "d1","d2", "d3","d4", "d5","d6", "d7","d8",  "4WR","12WR", "26WR"]

# c2 = ["sector", "fund","4-wkd", "d1","d2", "d3","d4", "d5","d6", "d7","d8","4WR","12WR", "26WR", "isin"]

# c4 = ["sector", "fund", "wd4", "wd12", "wd26", "wr4","wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "isin"]

# c4 = ["sector", "fund", "wd4", "wd12", "wd26", "wr4", "wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "fund_size", "isin"]


   def self.find_max(pdf_reader)
      reader = pdf_reader
      i = 0
      a = Time.now
      puts a
      reader.pages.each do |page|
        page.text.split("\n").each do |line|
          if line.scan(/\s{2}+/).size > i
            i = line.scan(/\s{2}+/).size
            puts "line size is #{line.scan(/\s{2}+/).size}"
          end
        end
      end
      return i
  end

  def self.check_creation_date(file)
       reader = PDF::Reader.new(file.tempfile.path)
       creation_date = get_create_date(reader)
       FileStat.where(creation_date: creation_date).exists?
  end



  def self.import(file)
    reader = PDF::Reader.new(file.tempfile.path)
    creation_date = get_create_date(reader)

        max = find_max(reader)
        columns = find_columns(max+1)
        read(columns, reader, creation_date)
    
     puts columns

  end

  def self.get_create_date(file)
    reader = file
    info_hash = reader.info
    creation_date = info_hash[:CreationDate][2..9]
  end


  def self.find_columns(max)
    case max.to_i
      when 13
        c = ["sector", "fund", "d1","d2", "d3","d4", "d5","d6", "d7","d8",  "4WR","12WR", "26WR"]
      when 15
        c = ["sector", "fund","4-wkd", "d1","d2", "d3","d4", "d5","d6", "d7","d8","4WR","12WR", "26WR", "isin"]
      when 21
        c = ["sector", "fund", "wd4", "wd12", "wd26", "wr4","wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "isin"]
      when 22
        c = ["sector", "fund", "wd4", "wd12", "wd26", "wr4", "wr12", "wr26","d1","d2", "d3","d4", "d5","d6", "d7","d8", "d9","d10","d11", "d12", "fund_size", "isin"]
    end
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

            unless Fund.where(name: r[i]["fund"]).exists?
              if r[i]["isin"].nil?
                Fund.create(name: r[i]["fund"], sector: r[i]["sector"])
              else
                Fund.create(name: r[i]["fund"], sector: r[i]["sector"], isin: r[i]["isin"].strip)
              end

            else
              fund_to_check = Fund.where(name: r[i]["fund"])
              if fund_to_check[0].isin.empty?
                fund_to_check[0].isin = r[i]["isin"].strip
              end
            end
            unless FundRecord.where(fund: r[i]["fund"], creation_date: r[i]["creation_date"] ).exists?
              FundRecord.create(r[i])
            end
            i += 1
          end
        end
      end
      puts "number of records added #{i}"
      puts r[i-1]
     puts "Column size #{columns.size} "
     b = Time.now
     c = b -a
     puts c
     # binding.pry
     FileStat.create(column_size: columns.size, creation_date: creation_date, records: i, time_to_load: c)
  end

end
