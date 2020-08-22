require 'total_discount_rule'
require 'item_discount_rule'

class Checkout

	attr_reader :items, :promotional_rules

	def initialize(promotional_rules: Array.new)
		@promotional_rules = promotional_rules
		@items = Array.new
	end

	def scan(item)
		items << item
	end

	def total(total_discount: TotalDiscountRule, item_rule: ItemDiscountRule)
		total = 0.00

		total_discount_rules = promotional_rules.select { |rule| rule.instance_of?(total_discount)}
		item_rules = promotional_rules.select { |rule| rule.instance_of?(item_rule)}

		total = apply_item_rule_discounts(item_rules, total)

		# Calculate totals for items without offers so far
		items.each do |item|
			total += item.price	
		end

		total = apply_total_discounts(total_discount_rules, total)

		total.round(2)
	end

	private

	def apply_item_rule_discounts(item_rules, total)
		item_rules.each do |rule|
			matching_items = items.select { |item| item.name == rule.item_name}
			next unless rule.meets_requirements?(matching_items)
			# Remove items so they are not added to total after discount added
			matching_items.each { |matching_item| items.delete(matching_item)}
			total += rule.calculate_offer(matching_items)
		end

		total
	end

	def apply_total_discounts(total_discount_rules, total)
		total_discount_rules.each do |rule|
			next unless rule.meets_requirements?(total)
			total = rule.calculate_offer(total)
		end

		total
	end
end