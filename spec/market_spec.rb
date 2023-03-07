require './lib/market'
require './lib/vendor'
require './lib/item'

RSpec.describe Market do

  let(:market) { Market.new("South Pearl Street Farmers Market") }

  describe '#initialize' do
    it 'exists' do
      expect(market).to be_a Market
    end
    
    it 'has attributes' do
      expect(market.name).to eq('South Pearl Street Farmers Market')
      expect(market.vendors).to eq([])
    end
  end
end