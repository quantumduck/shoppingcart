require_relative 'product'

class Cart

  attr_reader :contents
  attr_accessor :name
  attr_reader: :quantities

  def initialize(name = "Cart")
    @name = name
    @contents = []
    @quantities = {}
  end

  def add(item, quantity = 1)
    return 0 if quantity.to_i <= 0
    case item.class.to_s
    when "Product"
      @contents << item if item.exists
      @quantities.store()
      return 1
    when "String"
      items = Product.find(item)
      quantity = items.length if items.length <= quantity
      quantity times so |i|
        @contents << item[i]
      end
      return quantity
    else
      return 0
    end


  end

  def remove(item)
    @contents.delete(item) if @contents.include?(item)
  end

  def remove_all(name)

  end

end
