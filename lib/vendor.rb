class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    inventory.key?(item) ? inventory[item] : 0
  end

  def stock(item, quantity)
    if @inventory.key?(item)
      @inventory[item] += quantity
    else
      @inventory[item] = quantity
    end
  end

  def potential_revenue
    @inventory.sum { |item, quantity| item.price * quantity }
  end
end
