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

  validate :at_correct_time

  def score! match_home, match_away
    return if match_home.nil? or match_away.nil?

    if self.home.nil? || self.away.nil?
      self.update_attribute(:points, 0)
      return
    end

    points = 0

    points += 1 if self.home == match_home
    points += 1 if self.away == match_away

    puts "Vamos a Calcular Scores"
    puts "#{self.home}:#{self.away} vs #{match_home}:#{match_away}"

    match_diff = match_home - match_away
    user_diff = self.home - self.away

    points += 1 if match_diff == user_diff
    points += 2 if (
      (match_diff > 0 && user_diff > 0) ||
      (match_diff < 0 && user_diff < 0) ||
      (match_diff == 0 && user_diff == 0)
    )

    self.update_attribute(:points, points)
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

  def at_correct_time
    errors.add(:base, 'ya no se aceptan cambios!') if (!self.match_pool.bets_opened_at || Time.now > self.match.when)
  end
end
