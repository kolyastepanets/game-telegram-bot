class User < ApplicationRecord
  validates :nickname, uniqueness: true, allow_nil: true

  # has_many :game_users
  # has_many :games, through: :game_users
end
