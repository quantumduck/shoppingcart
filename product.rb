class Product

  @@inventory = []
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

  attr_reader name
  attr_reader price
  attr_reader tax_rate

  def initizlize(name, price, tax_rate = :normal)
    @name = name
    @price = price
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

end
