class Product < ApplicationRecord
  enum status: [:available, :reserved, :sold]
  enum tax: {tax_exempt: 0, normal_tax: 15, import_tax: 25}

  def total
    ((price * (100 + tax)).to_f / 100.0).round
  end

end
