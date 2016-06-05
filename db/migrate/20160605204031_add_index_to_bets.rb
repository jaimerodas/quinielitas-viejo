class AddIndexToBets < ActiveRecord::Migration[5.0]
  def change
    add_index :bets, [:user_id, :match_id], unique: true
  end
end
