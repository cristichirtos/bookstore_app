class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :author, presence: true, length: { maximum: 255 }
  validates :genre, presence: true, length: { maximum: 50 }
  validates :publishing_date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :publisher, presence: true
end
