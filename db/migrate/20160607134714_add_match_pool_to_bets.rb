class AddMatchPoolToBets < ActiveRecord::Migration[5.0]
  def change
    add_reference :bets, :match_pool, foreign_key: true
  end
end
