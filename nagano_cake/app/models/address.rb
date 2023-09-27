class Address < ApplicationRecord

  belongs_to :customer
  validates :name, presence: true
  validates :address, presence: true
  validates :postcode, presence: true, format: {with: /\A\d{7}\z/}, numericality: { only_integer: true }

end
