class Item < ApplicationRecord
  has_one_attached :image
  has_many :genres
  enum status: { on_sale: 0, off_sale: 1 }
  belongs_to :genre
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_details
  validates :introduction, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :is_sale, inclusion: {in: [true, false]}
end
