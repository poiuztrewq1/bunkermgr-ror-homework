class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :bunkers

  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :name, presence: true
end
