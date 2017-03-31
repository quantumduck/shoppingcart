require_relative 'product'

class Cart

  @@all = []

  # def self.check_for(item)
  #   carts_containing_item = []
  #   @@all.each do |cart|
  #     cart.contents.each do |product|
  #       if (product == item)
  #         carts_containing_item << cart
  #         break
  #       end
  #     end
  #   end
  #   carts_containing_item
  # end

  # def self.clear_all(item)
  #
  # end

  attr_reader :contents
  attr_accessor :name
  attr_reader: :quantities

  def initialize(name = "Cart")
    @name = name
    @contents = []
    @quantities = {}
    @@all << self
  end

  def add(item, quantity = 1)
    return 0 if quantity.to_i <= 0
    case item.class.to_s
    when "Product"
      if (item.exists && item.available)
        @contents << item
        item.available = false
      end
      @quantities.store()
      return 1
    when "String"
      items = Product.find(item)
      num_added = 0
      i = 0
      while ((num_added < quantity) && (i < items.length))
        if item.available
          @contents << item[i]
          item.available = false
          num_added += 1
        end
      end
      return num_added
    else
      return 0
    end
  end

  def remove(item)
    if @contents.include?(item)
      @contents.delete(item)
      item.available = true
    end
  end

  def remove_all(name)

  end

end
