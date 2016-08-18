class User < ApplicationRecord

  has_many :reviews

  has_secure_password

  validates :firstname, :lastname, :email,
    presence: true

  validates :password,
    presence: true, on: :create
end
