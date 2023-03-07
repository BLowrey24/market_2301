require './lib/vendor'
require './lib/item'

RSpec.describe Vendor do

  let(:vendor1) { Vendor.new('Rocky Mountain Fresh') }
  let(:vendor2) { Vendor.new('Ba-Nom-a-Nom') }
  let(:vendor3) { Vendor.new('Palisade Peach Shack') }
  let(:item1) { Item.new({ name: 'Peach', price: "$0.75" }) }
  let(:item2) { Item.new({ name: 'Tomato', price: '$0.50' }) } 
  let(:item3) { Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'}) } 
  let(:item4) { Item.new({name: 'Banana Nice Cream', price: '$4.25'}) } 

  describe '#initialize' do
    it 'exists' do
      expect(vendor1).to be_a Vendor
    end
    
    it 'has attributes' do
      expect(vendor1.name).to eq('Rocky Mountain Fresh')
      expect(vendor1.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'checks the stock for an item and returns the number of items there are in stock' do
      expect(vendor1.check_stock(item1)).to eq(0)
    end
  end
  
  describe '#stock' do
    it 'adds an item to the inventory hash or adds to the item already in the hash' do
      vendor1.stock(item1, 30)
      expect(vendor1.inventory).to eq({item1 => 30})
      expect(vendor1.check_stock(item1)).to eq(30)
      
      vendor1.stock(item1, 25)
      expect(vendor1.check_stock(item1)).to eq(55)
      
      vendor1.stock(item2, 12)
      expect(vendor1.inventory).to eq({item1 => 55, item2 => 12})
    end
  end

  describe '#potential_revenue' do
    before do
      vendor1.stock(item1, 35) 
      vendor1.stock(item2, 7) 
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
    end

    it 'returns the potential revenue of the item' do
      expect(vendor1.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end
end