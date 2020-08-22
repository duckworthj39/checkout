require 'spec_helper'

RSpec.describe Checkout do

	context 'when there are no offers' do
		let(:co) { Checkout.new }

		it 'adds two items and returns the correct total' do
			item1 = double(price: 1)
			item2 = double(price: 2)
			co.scan(item1)
			co.scan(item2)

			expect(co.total).to eq(3)
		end

		it 'adds three items and returns the correct total' do
			item1 = double(price: 1)
			item2 = double(price: 2)

			co.scan(item1)
			co.scan(item2)
			co.scan(item2)

			expect(co.total).to eq(5)
		end
	end

	context 'when there is an 10% off totals off totals of £60' do

		it 'uses total_discount rules to the determine price' do

			promotional_rules = [spy(
				'TotalDiscountRule', 
				meets_requirements?: true,
				calculate_offer: 76.50
			)]
			co = Checkout.new(promotional_rules: promotional_rules)

			item1 = spy(price: 40.00)
			item2 = spy(price: 45.00)

			co.scan(item1)
			co.scan(item2)

			allow(promotional_rules[0]).to receive(:instance_of?).with(anything()).and_return(true)

			total = co.total(total_discount: double)

			expect(item1).to have_received(:price).once
			expect(item2).to have_received(:price).once
			expect(promotional_rules[0]).to have_received(:meets_requirements?).once
			expect(promotional_rules[0]).to have_received(:calculate_offer).once
			expect(total).to eq(76.50)

		end
	end
end