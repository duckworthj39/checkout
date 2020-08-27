class ItemDiscountRule

	attr_reader :requirement_quantity, :new_price, :item_name

	def initialize(requirement_quantity:, new_price:, item_name:)
		@requirement_quantity = requirement_quantity
		@new_price = new_price
		@item_name = item_name
	end

	def meets_requirements?(items)
		items.count >= requirement_quantity
	end

	# calculates the new total by taking away the difference
	# from the discounted price
	def calculate_total_after_offer(total, items)
		new_item_total = new_price * items.count
		old_item_total = items.first.price * items.count

		deduction = (old_item_total - new_item_total).round(2)
		total - deduction
	end
end