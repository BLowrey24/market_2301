require './lib/market'
require './lib/vendor'
require './lib/item'

RSpec.describe Market do

  let(:market) { Market.new('South Pearl Street Farmers Market') }
  let(:vendor1) { Vendor.new('Rocky Mountain Fresh') }
  let(:vendor2) { Vendor.new('Ba-Nom-a-Nom') }
  let(:vendor3) { Vendor.new('Palisade Peach Shack') }
  let(:item1) { Item.new({ name: 'Peach', price: '$0.75' }) }
  let(:item2) { Item.new({ name: 'Tomato', price: '$0.50' }) } 
  let(:item3) { Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'}) } 
  let(:item4) { Item.new({name: 'Banana Nice Cream', price: '$4.25'}) } 
  let(:item5) { Item.new({name: 'Apple', price: '$0.25'}) } 

  before do
    vendor1.stock(item1, 35) 
    vendor1.stock(item2, 7) 
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
  end

  describe '#initialize' do
    it 'exists' do
      expect(market).to be_a Market
    end
    
    it 'has attributes' do
      expect(market.name).to eq('South Pearl Street Farmers Market')
      expect(market.vendors).to eq([])
    end
  end

  describe '#add_vendor' do
    it 'adds a vender to the markets vendors array' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end
  end

  describe '#vendor_names' do
    it 'returns the name of all the vendors in an array' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.vendor_names).to eq([vendor1.name, vendor2.name, vendor3.name])
    end
  end

  describe '#vendors_that_sell' do
    it 'returns an array of the vendors that sell the item in the argument' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
  end

  describe '#sorted_item_list' do
    it 'returns list of all the names of the items the vendors have in stock alphabetically without duplicates' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.sorted_item_list).to eq(['Banana Nice Cream', 'Peach', 'Peach-Raspberry Nice Cream', 'Tomato'])
    end
  end

  describe '#total_inventory' do
    it 'returns a hash with items as keys and hash as values' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expected_hash = {
      item1 => { quantity: 100, vendors: [vendor1, vendor3] },
      item2 => { quantity: 7, vendors: [vendor1] },
      item3 => { quantity: 25, vendors: [vendor2] },
      item4 => { quantity: 50, vendors: [vendor2] }
    }

    expect(market.total_inventory).to eq(expected_hash)
    end
  end

  describe '#overstocked_items' do
    it 'returns the item that is sold by more then one vendor and the quantity is over 50' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.overstocked_items).to eq([item1])
    end

    it 'can return multiple items' do
      vendor3.stock(item5, 55)
      vendor3.stock(item2, 7)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.overstocked_items).to eq([item1, item2, item5])
    end
  end
end