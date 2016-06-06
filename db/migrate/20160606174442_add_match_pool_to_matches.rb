class AddMatchPoolToMatches < ActiveRecord::Migration[5.0]
  def change
    add_reference :matches, :match_pool, foreign_key: true
  end
end
