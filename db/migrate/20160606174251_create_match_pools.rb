class CreateMatchPools < ActiveRecord::Migration[5.0]
  def change
    create_table :match_pools do |t|
      t.string :name
      t.datetime :bets_opened_at
      t.datetime :bets_closed_at
      t.datetime :results_given_at

      t.timestamps
    end
  end
end
