require 'spec_helper'

RSpec.describe Checkout do


	let(:promotional_rules) {}
	let(:co) { Checkout.new }

	# If I was working on an api these would usually be request specs
	context 'integration specs' do
		it 'returns correct total for 001, 002, 003' do
			# Arrange
			item1 = Item.new(001, 'Lavender heart', 9.25)
			item2 = Item.new(002, 'Personalised cufflinks', 45.00)
			item3 = Item.new(003, 'Kids T-shirt', 19.95)

			co.scan(item1)
			co.scan(item2)
			co.scan(item3)
			# Act
			total = co.total
			# Assert
			expect(total).to eq(74.20)
		end
	end

	xcontext 'challenge requirements' do
		it 'returns the correct total for 001, 002, 003' do
			co.scan(001)
			co.scan(002)
			co.scan(003)
			expect(co.total).to eq(9.25)
		end

		it 'returns the correct total for 001, 003, 001' do
			co.scan(001)
			co.scan(003)
			co.scan(001)
			expect(co.total).to eq(45.00)
		end

		it 'returns the correct total for 001, 002, 001, 003' do
			co.scan(001)
			co.scan(002)
			co.scan(001)
			co.scan(003)
			expect(co.total).to eq(19.95)
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
