require './lib/vendor'

RSpec.describe Vendor do

  let(:vendor) { Vendor.new('Rocky Mountain Fresh') }

  describe '#initialize' do
    it 'exists' do
      expect(vendor).to be_a Vendor
    end
    
    it 'has attributes' do
      expect(vendor.name).to eq('Rocky Mountain Fresh')
      expect(vendor.inventory).to eq([])
    end
  end

  describe '#check_stock' do
    it 'checks the stock for an item and returns the number of items there are in stock' do
      expect(vendor.check_stock(item1)).to eq(0)
    end
  end
end