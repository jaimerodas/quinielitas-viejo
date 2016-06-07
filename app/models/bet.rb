class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match
  belongs_to :match_pool

  validates :home, numericality: {
    only_integer: true,
    less_than: 50,
    greater_than_or_equal_to: 0
  }, if: '!home.nil?'
  validates :away, numericality: {
    only_integer: true,
    less_than: 50,
    greater_than_or_equal_to: 0
  }, if: '!away.nil?'
end
