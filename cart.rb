require_relative 'product'

class Cart

  ### attr available in Product now used to prevent item from being in
  ### more than one card. @@all and class methods no longer required.
  # @@all = []

  attr_reader :contents
  attr_accessor :name
  attr_reader: :quantities

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

  def initialize(name = "Cart")
    @name = name
    @contents = []
    # @quantities = {}
    # @@all << self
  end

  def add(item, quantity = 1)
    return 0 if quantity.to_i <= 0
    case item.class.to_s
    when "Product"
      if (item.exists && item.available)
        @contents << item
        # if (@quantities[item.name] == nil)
        #   @quantities[item.name] = 1
        # else
        #   @quantities[item.name] += 1
        # end
        item.available = false
      end
      return 1
    when "String"
      items = Product.find(item)
      num_added = 0
      i = 0
      while ((num_added < quantity) && (i < items.length))
        if items[i].available
          @contents << items[i]
          # if (@quantities[items[i].name] == nil)
          #   @quantities[items[i].name] = 1
          # else
          #   @quantities[items[i].name] += 1
          # end
          items[i].available = false
          num_added += 1
        end
      end
      return num_added
    else
      return 0
    end
  end

  def quantity_of(name)
    quantity = 0
    @contents.each { |item| quantity += 1 if item.name == name }
    quantity
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
