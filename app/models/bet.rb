class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :home, numericality: true, if: '!home.nil?'
  validates :away, numericality: true, if: '!away.nil?'
end
