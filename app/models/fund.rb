class Fund < ActiveRecord::Base

  

  attr_accessible :continent, :country_name, :name, :sector, :isin, :fund_record_ids, :country_id, :region_id, :saltydog_group_id, :portfolio_record_ids, :current_price
  

  has_many :fund_records
  belongs_to :country
  belongs_to :region
  belongs_to :saltydog_group
  has_many :portfolio_records



  
    def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |fund_record|
        csv << fund_record.attributes.values_at(*column_names)
      end
    end
  end


  # def self.find_funds(funds_map)
  #     funds_map.shift
  #     fund_ids = []

  #     filestat = FileStat.find_last

  #     unless funds_map.empty?
  #       funds_map.each do |fund|
  #         fund_ids << fund[1]
  #       end
  #        fund_records = FundRecord.where("fund_id in(?) and file_stat_id = ? ", fund_ids, filestat.id) 
  #        funds = Fund.where("id in(?)", fund_ids)
  #        [fund_recrods, funds]
  #     end
  # end


  def find_price(isin)
    fund_to_update = Fund.find_by_isin(isin)
    isin = isin + ".L"
    stock = StockQuote::Stock.quote(isin)

    if stock.last_trade_price_only.nil?

      fund_to_update.current_price = 0.00
      fund_to_update.save

    else

      fund_to_update.current_price = stock.last_trade_price_only
      fund_to_update.save

    end

      fund_to_update.current_price

  end

end
