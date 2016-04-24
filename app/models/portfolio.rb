class Portfolio < ActiveRecord::Base
  attr_accessible :name, :user_id, :portfolio_record_ids, :total_funding, :current_value
  has_many :portfolio_records, dependent: :destroy
  belongs_to :current_portfolio, dependent: :destroy

		def get_current_value(portfolio)

		
  			
  			if portfolio.current_portfolio.current_value.nil? || portfolio.current_portfolio.updated_at != Date.today

		  		portfolio_value = 0

				portfolio.portfolio_records.each do |record|
					if record.fund.name != "Cash"
						price = record.fund.find_price(record.fund.isin)
					else
						price = 1.0
					end
						portfolio_value += record.units * price
					
				end

				portfolio_value.round(2)
				
			else
				portfolio.current_portfolio.current_value
			end

  		end

end
