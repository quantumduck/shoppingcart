class Product

  @@inventory = []
  @@sales = []
  @@normal_tax = 15
  @@import_tax = 25
  @@serial_count = 0

  def self.find(value, field = :name, cmp = :equal)
    results = []
    @@inventory.each do |product|
      case field
      when :name
        results << product if product.name == value
      when :price
        case cmp
        when :equal
          results << product if product.price == value
        when :lessthan
          results << product if product.price < value
        end
      end
    end
    results
  end

  attr_reader :name
  attr_reader :tax_rate
  # attr_reader price # redefined below

  def initialize(name, price, tax_rate = :normal)
    @name = name
    case price.class.to_s
    when "Integer"
      @price_cents = 100 * price
      puts "integer"
    when"Float"
      @price_cents = (100.0 * price.round(2)).to_i
      puts "float"
    else puts price.class
    end
    @tax_rate =
    case tax_rate
    when :untaxed
      0
    when :import
      @@import_tax
    else
      @@normal_tax
    end
    @serial = @@serial_count
    @@serial_count += 1
    @@inventory << self
  end

  def price
    (@price_cents.to_f / 100.0).round(2)
  end

  def total_price
    base = @price_cents
    tax = ((base * @tax_rate).round(-2)) / 100
    total = ((base + tax).to_f / 100.0).round(2)
  end

    def sell
    sold =  @@inventory.include?(self)
    if sold
      @@sales << self
      @@inventory.delete(self)
    end
    sold
  end

end
