RSpec.describe ItemDiscountRule do

	it 'calculates item rule total' do
		params = { requirement_quantity: 0, new_price: 8.25, item_name: 'test_item'}
		rule = ItemDiscountRule.new(params)
		items = [double(price: 9.50), double(price: 9.50)]
		total = items[0].price + items[1].price
		expect(rule.calculate_total_after_offer(total, items)).to eq(16.50)
	end

	it 'returns true when requirements met' do
		rule = ItemDiscountRule.new({requirement_quantity: 2, new_price: 8.25, item_name: 'test_item'})
		items = [double(name: 'test_item'), double(name: 'test_item')]
		expect(rule.meets_requirements?(items)).to be true
	end

	it 'returns false when requirements not met' do
		rule = ItemDiscountRule.new({requirement_quantity: 2, new_price: 8.25, item_name: 'test_item'})
		items = [double(name: 'test_item')]
		expect(rule.meets_requirements?(items)).to be false
	end
end