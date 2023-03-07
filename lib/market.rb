class Market
  attr_reader :name, 
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    # vendors.map(&:name)
    vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    vendors.select { |vendor| vendor.inventory.key?(item) }
  end

  def sorted_item_list
    items = vendors.flat_map { |vendor| vendor.inventory.keys.map(&:name) }
    items.uniq.sort
  end

  def total_inventory
  inventory = {}
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item] ||= { quantity: 0, vendors: [] }
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
  inventory
  end

  def overstocked_items
    overstocked_items = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        vendors_selling_item = vendors_that_sell(item)
        total_quantity = vendors_selling_item.sum { |vendor| vendor.check_stock(item) }
        if vendors_selling_item.length > 1 || total_quantity > 50
          overstocked_items << item unless overstocked_items.include?(item)
        end
      end
    end
    overstocked_items
  end
end
