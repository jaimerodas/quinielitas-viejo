class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references :user, foreign_key: true
      t.references :match, foreign_key: true
      t.integer :home
      t.integer :away
      t.integer :points

      t.timestamps
    end
  end
end
