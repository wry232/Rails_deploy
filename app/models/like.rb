class Like < ApplicationRecord
  belongs_to :user
  belongs_to :secret
  has_many :users, through: :users
end
