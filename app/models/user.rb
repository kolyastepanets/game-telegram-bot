class User < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true
end
