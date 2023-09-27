class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def total
    (item.price * 1.1) * amount
  end
end
