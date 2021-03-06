require 'spec_helper'

RSpec.describe Checkout do

	let(:lavender_heart) { Item.new(001, 'Lavender heart', 9.25) }
	let(:personalised_cufflinks) { Item.new(002, 'Personalised cufflinks', 45.00) }
	let(:kids_tshirt) { Item.new(003, 'Kids T-shirt', 19.95) }

	# If I was working on an api these would usually be request specs
	context 'integration specs' do
		context 'without offers' do

			let(:promotional_rules) {}
			let(:co) { Checkout.new }

			it 'returns correct total for 001, 002, 003' do
				# Having a new item object for each item added allows for 
				# unique properties per item such as reducing price based on the date
				# it runs out

				co.scan(lavender_heart)
				co.scan(personalised_cufflinks)
				co.scan(kids_tshirt)

				total = co.total

				expect(total).to eq(74.20)
			end
		end

		context 'with 10% off totals over a certain amount offer' do
			it 'returns the correct total when over required amount' do
				
				params = { requirement_price: 60.00, discount: 20.00 }
				rule = RuleFactory.new.get_rule('TotalDiscount', params)

				promotional_rules = [rule]
				co = Checkout.new(promotional_rules: promotional_rules)
	
				co.scan(personalised_cufflinks)
				co.scan(personalised_cufflinks)
	
				total = co.total
	
				expect(total).to eq(72.00)
	
			end

			it 'returns the correct total when below the required amount' do

				params = { requirement_price: 100.00, discount: 20.00 }
				rule = RuleFactory.new.get_rule('TotalDiscount', params)

				promotional_rules = [rule]
				co = Checkout.new(promotional_rules: promotional_rules)
	
				co.scan(personalised_cufflinks)
				co.scan(personalised_cufflinks)
	
				total = co.total
	
				expect(total).to eq(90.00)
			end
		end

		context 'when there is more than one of a certain item the price is reduced' do
			it 'returns the correct total when when requirement is met' do
				requirement_quantity = 2
				new_price = 8.50

				params = {requirement_quantity: 2, new_price: 8.50, item_name: lavender_heart.name}
				rule = RuleFactory.new.get_rule('ItemDiscount', params)

				promotional_rules = [rule]
				co = Checkout.new(promotional_rules: promotional_rules)
	
				co.scan(lavender_heart)
				co.scan(lavender_heart)
	
				total = co.total
	
				expect(total).to eq(17.00)
			end
		end
	end



	context 'challenge requirements' do
		let(:promotional_rules) do

			rule1 = RuleFactory.new.get_rule(
				'ItemDiscount',
				{ requirement_quantity: 2, new_price: 8.50, item_name: lavender_heart.name }
			)

			rule2 = RuleFactory.new.get_rule(
				'TotalDiscount',
				{ requirement_price: 60.00, discount: 10.00 }
			)

			$promotional_rules = [rule1, rule2]
		end

		let(:co) { Checkout.new(promotional_rules: promotional_rules) }

		it 'returns the correct total for 001, 002, 003' do
			co.scan(lavender_heart)
			co.scan(personalised_cufflinks)
			co.scan(kids_tshirt)
			expect(co.total).to eq(66.78)
		end

		it 'returns the correct total for 001, 003, 001' do
			co.scan(lavender_heart)
			co.scan(kids_tshirt)
			co.scan(lavender_heart)
			expect(co.total).to eq(36.95)
		end

		it 'returns the correct total for 001, 002, 001, 003' do
			co.scan(lavender_heart)
			co.scan(personalised_cufflinks)
			co.scan(lavender_heart)
			co.scan(kids_tshirt)
			expect(co.total).to eq(73.76)
		end
	end
end


# Product code  | Name                   | Price
# ----------------------------------------------------------
# 001           | Lavender heart         | £9.25
# 002           | Personalised cufflinks | £45.00
# 003           | Kids T-shirt           | £19.95

# Test data
# ---------
# Basket: 001,002,003
# Total price expected: £66.78

# Basket: 001,003,001
# Total price expected: £36.95

# Basket: 001,002,001,003
# Total price expected: £73.76
