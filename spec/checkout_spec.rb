require 'spec_helper'

RSpec.describe Checkout do

	context 'when there are no offers' do
		let(:co) { Checkout.new }
		it 'adding two items returns the correct total' do
			item1 = double(price: 1)
			item2 = double(price: 2)
			co.scan(item1)
			co.scan(item2)

			expect(co.total).to eq(3)
		end

		it 'adding three items returns the correct total' do
			item1 = double(price: 1)
			item2 = double(price: 2)

			co.scan(item1)
			co.scan(item2)
			co.scan(item2)

			expect(co.total).to eq(5)
		end
	end
end