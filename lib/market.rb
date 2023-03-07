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
end
