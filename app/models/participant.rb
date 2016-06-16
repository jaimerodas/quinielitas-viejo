class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :match_pool

  def recalculate_points
    bets = Bet.select('SUM(points) total, user_id')
      .where(user: self.user, match_pool: self.match_pool).group('user_id')
    self.update_attribute(:points, bets[0].total) if bets
  end
end
