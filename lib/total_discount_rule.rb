class TotalDiscountRule

	attr_reader :requirement_price, :discount

	# discount is a percentage
	def initialize(requirement_price, discount)
		@requirement_price = requirement_price
		@discount = discount
	end

	def meets_requirements?(total)
		total >= requirement_price
	end

	def calculate_offer(total)
		discount_value = total * (discount.to_f / 100)
		(total - discount_value).round(2)
	end
end