class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :home
      t.integer :away
      t.datetime :when

      t.timestamps
    end
  end
end
