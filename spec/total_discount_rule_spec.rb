require 'spec_helper'

RSpec.describe TotalDiscountRule do

	it 'calculates the correct total' do
		rule = TotalDiscountRule.new({requirement_price: 0, discount: 50})
		expect(rule.calculate_total_after_offer(4.50)).to eq(2.25)
	end

	it 'returns true when the requirement is met' do
		rule = TotalDiscountRule.new({requirement_price: 50, discount: 50})
		expect(rule.meets_requirements?(51)).to be true
	end

	it 'returns false when the requirement is not met' do
		rule = TotalDiscountRule.new({requirement_price: 50, discount: 50})
		expect(rule.meets_requirements?(49)).to be false
	end
end