class Product

  @@inventory = []    # All unsold products
  @@sales = []        # All sold products
  @@normal_tax = 15   # Tax rate for general goods
  @@import_tax = 25   # Tax rate for imported goods
  @@serial_count = 0  # Count of total number of products created

  attr_reader :name
  attr_reader :tax_rate
  # attr_reader price         # redefined below
  attr_reader :price_cents  # Used to check exact price matches
  attr_accessor :available  # Product from being in > 1 Cart

  def self.find(value, field = :name, cmp = :less_or_eq)
  # Search method to find product based on name or price:
    results = []
    # Go through inventory array
    @@inventory.each do |product|
      # check for matches depending on search field
      case field
      when :name
        # Default add products that match the name
        results << product if (product.name == value)
      when :price
        # If price selected, use a comparison
        case cmp
        when :equal
          results << product if product.price == value
        when :less_or_eq
          results << product if product.price <= value
        end
      end
    end
    results # Return an array of products
  end

  def self.exits(item)
    # Simple check if item is in inventory
    @@inventory.include?(item)
  end

  def self.revenue
    rev = 0
    @@sales.each do |item|
      rev += item.price
    end
    rev
  end

  def self.collected_taxes
    taxes = 0
    @@sales.each do |item|
      taxes += (item.total_price - item.price)
    end
    taxes
  end

################################################################


  def initialize(name, price, tax_rate = :normal, quantity = 1)
    # Make sure there is a positive quantity:
    if (quantity.to_i <= 0)
      puts "ERROR: Quantity must be >= 1"
      return nil
    end
    # Record instance variables:
    @name = name
    @available = true
      # Record price in cents as an integer
    case price.class.to_s
    when "Integer"
      @price_cents = 100 * price
    when"Float"
      @price_cents = (100.0 * price.round(2)).to_i
    else
      puts "ERROR: Price must be an Integer or a Float."
      return nil
    end
      # Use class variables to set tax rate according to flags
    @tax_rate =
    case tax_rate
    when :untaxed
      0
    when :import
      @@import_tax
    else
      @@normal_tax
    end
      # Provide a unique serial number
    @serial = @@serial_count
    # check for name conflicts:
    if self.check_conflict
      puts "ERROR: Name conflict."
      return nil
    end
    # add to incentory
    @@serial_count += 1
    @@inventory << self
    # if quantity > 1, recursively keep adding:
    quantity -= 1
    Product.new(name, price, tax_rate, quantity) if quantity > 0
  end

  def check_conflict
    conflict = false
    # find name matches
    matches = Product.find(self.name)
    matches.each do |match|
      # check if name matches have different prices or tax rates
      conflict = true if (match.price_cents != self.price_cents)
      conflict = true if (match.tax_rate != match.tax_rate)
    end
    conflict
  end

  def price
  # convert price from integer in cents to float in dollars
    (@price_cents.to_f / 100.0).round(2)
  end

  def total_price
  # return total price as float
    base = @price_cents
    tax = ((base * @tax_rate).round(-2)) / 100
    total = ((base + tax).to_f / 100.0).round(2)
  end

  def sell
  # Move item from inventory array to sales array
    # check if item is in inventory
    sold =  @@inventory.include?(self)
    if sold
      @@sales << self
      @@inventory.delete(self)
    end
    sold # Return whether sale took place
  end

end
