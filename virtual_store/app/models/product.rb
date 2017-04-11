class Product < ApplicationRecord
  enum status: [:available, :reserved, :sold]
  enum tax: {tax_exempt: 0, normal_tax: 15, import_tax: 25}

  def total
    ((price * (100 + tax)).to_f / 100.0).round
  end

  def formatted_price
    extra_zero = ((price % 100) <  10)? "0" : ""
    "$" + (price / 100).to_s + "." + extra_zero + (price % 100).to_s
  end

  def formatted_total
    extra_zero = ((total % 100) <  10)? "0" : ""
    "$" + (total / 100).to_s + "." + extra_zero + (total % 100).to_s
  end

end
