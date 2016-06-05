class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :home, presence: true, numericality: true
  validates :away, presence: true, numericality: true
end
