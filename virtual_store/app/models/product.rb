class Product < ApplicationRecord
  enum status: [:available, :reserved, :sold]
  enum tax: [:exempt, :normal, :import]

  def total
    ((price * (100 + tax_rate)).to_f / 100.0).round
  end

  def tax_rate
    case tax
    when :exempt then 0
    when :normal then 15
    when :import then 25
  end

end
