class MatchPool < ApplicationRecord
  has_many :matches
  has_many :bets

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

  def next_action
    return 'Abrir Apuestas' unless self.bets_opened_at
    return 'Cerrar Apuestas' if self.bets_opened_at
    return 'Cerrar Quiniela'
  end

end
