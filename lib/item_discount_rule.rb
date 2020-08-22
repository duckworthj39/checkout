class ItemDiscountRule

	attr_reader :requirement_quantity, :new_price, :item_name

	def initialize(requirement_quantity, new_price, item_name)
		@requirement_quantity = requirement_quantity
		@new_price = new_price
		@item_name = item_name
	end

	def meets_requirements?(items)
		items.count >= requirement_quantity
	end

	def calculate_offer(items)
		(items.count * new_price).round(2)
	end
end