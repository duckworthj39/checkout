class TotalDiscountRule

	attr_reader :requirement_price, :discount

	# discount is a percentage
	def initialize(requirement_price:, discount:)
		@requirement_price = requirement_price
		@discount = discount
	end

	def meets_requirements?(total)
		total >= requirement_price
	end

	def calculate_total_after_offer(total)
		deduction = total * (discount.to_f / 100)
		(total - deduction).round(2)
	end
end