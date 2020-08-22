RSpec.describe ItemDiscountRule do

	it 'calculates item rule total' do
		rule = ItemDiscountRule.new(0, 8.25, 'test_item')
		items = [double(price: 1.00), double(price: 1.00)]
		expect(rule.calculate_offer(items)).to eq(16.50)
	end

	it 'returns true when requirements met' do
		rule = ItemDiscountRule.new(2, 8.25, 'test_item')
		items = [double(name: 'test_item'), double(name: 'test_item')]
		expect(rule.meets_requirements?(items)).to be true
	end

	it 'returns false when requirements not met' do
		rule = ItemDiscountRule.new(2, 8.25, 'test_item')
		items = [double(name: 'test_item')]
		expect(rule.meets_requirements?(items)).to be false
	end
end