class Role < ApplicationRecord
  enum name: [:employee, :admin]
  has_and_belongs_to_many :users
end
