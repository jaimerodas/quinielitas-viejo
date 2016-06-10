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

  validate :before_the_game

  def score! match_home, match_away
    self.points = 0
    self.save and return if self.home.nil? or self.away.nil?

    points = 0

    points += 1 if self.home == match_home
    points += 1 if self.away == match_away

    match_diff = match_home - match_away
    user_diff = self.home - self.away

    points += 1 if match_diff == user_diff
    points += 2 if (
      (match_diff > 0 && user_diff > 0) ||
      (match_diff < 0 && user_diff < 0) ||
      (match_diff == 0 && user_diff == 0)
    )

    self.points = points
    self.save
  end

  def when
    self.starts_at || self.match.when
  end

  def month
    I18n.l self.when, format: :month
  end

  def date
    I18n.l self.when, format: :date
  end

  def time
    I18n.l self.when, format: :short_time
  end

  private

  def before_the_game
    errors.add(:base, 'el partido ya empezó!') if (!self.match_pool.bets_opened_at ||  self.match.when < Time.now)
  end
end
