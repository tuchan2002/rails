class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true
end
