class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_and_belongs_to_many :roles
end
