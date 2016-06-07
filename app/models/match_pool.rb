class MatchPool < ApplicationRecord
  has_many :matches
  has_many :bets

  def accepts_bets?
    ( self.bets_opened_at and self.bets_closed_at.nil? )
  end

  def accepts_matches?
    self.bets_opened_at.nil?
  end

  def open_betting!
    unless self.bets_opened_at
      self.bets_opened_at = Time.now
      self.save
    end
  end

  def close_betting!
    if self.bets_opened_at
      self.bets_closed_at = Time.now
      self.save
    end
  end

  def status
    return 'editando' if self.accepts_matches?
    return 'apostando' if self.accepts_bets?
    return 'jugando'
  end

end
