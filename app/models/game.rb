class Game < ApplicationRecord
  validates :name, presence: true

  belongs_to :platform
end
