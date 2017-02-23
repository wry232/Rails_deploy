class User < ApplicationRecord
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: email_regex }
end
