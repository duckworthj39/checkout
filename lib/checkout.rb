class Checkout 

	attr_reader :items

	def initialize
		@items = Array.new
	end

	def scan(item)
		items << item
	end

	def total
		total = 0.00

		items.each do |item| 
			total += item.price
		end
		total
	end

end