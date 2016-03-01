module PortfoliosHelper

	def current_value(record)
		
		(record.current_value/100).round(2)
	end

	def original_cost(record)
		(record.allocation/100 * record.total_fund).round(2)
		
	end


	def monetary_profit(record)
		
		(current_value(record) - original_cost(record)).round(2)
		
	end
	def percent_profit(record)
		
		percent_value = ((current_value(record) / original_cost(record)-1)*100).round(2)
		"#{percent_value} %"
	end

	def original_allocation(record)

		"#{record.allocation} %"
		
	end


	def portfolio_value(portfolio)

		portfolio.portfolio_records.map {|t| t.units * t.fund.current_price}.reduce(:+)
	end

	def current_portfolio_percent(record, portfolio)

		percent_value = ((current_value(record) / current_portfolio(portfolio))*100).round(2)

		"#{percent_value} %"
	end

	def current_portfolio(portfolio)

		portfolio_value = 0

		portfolio.portfolio_records.each do |record|

			portfolio_value += current_value(record)

		end
		portfolio_value.round(2)
	end
end
