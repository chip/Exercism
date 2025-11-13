class BoutiqueInventory
  CHEAP_PRICE = 30

  def initialize(items)
    @items = items
  end

  def item_names
    items.map { |i| i[:name] }.sort
  end

  def cheap
    items.select { |i| i[:price] < CHEAP_PRICE }
  end

  def out_of_stock
    items.select { |i| i[:quantity_by_size].empty? }
  end

  def stock_for_item(name)
    items.find { |i| i[:name] == name }[:quantity_by_size]
  end

  def total_stock
    items.sum { |i| i[:quantity_by_size].values.sum }
  end

  private

  attr_reader :items
end
