class Checkout 

	require 'total_discount_rule'

	attr_reader :items, :promotional_rules

	def initialize(promotional_rules: Array.new)
		@promotional_rules = promotional_rules
		@items = Array.new
	end

	def scan(item)
		items << item
	end

	def total(total_discount: TotalDiscountRule)
		total = 0.00

		total_discount_rules = promotional_rules.select { |rule| rule.instance_of?(total_discount)}

		# promotional_rules.each do |rule|
		# 	next unless rule.apply?(items)
		# 	total += rule.calculate_offer(items)
		# end


		items.each do |item|
			total += item.price	
		end

		total_discount_rules.each do |rule|
			next unless rule.meets_requirements?(total)
			total = rule.calculate_offer(total)
		end

		total
	end

end