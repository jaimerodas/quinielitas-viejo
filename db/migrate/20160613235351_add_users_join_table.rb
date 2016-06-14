class AddUsersJoinTable < ActiveRecord::Migration[5.0]
  def up
    create_table :participants do |t|
      t.references :user, foreign_key: true
      t.references :match_pool, foreign_key: true
      t.integer "points", default: 0
      t.boolean "paid", default: false
      t.index [:user_id, :match_pool_id], unique: true
    end

    MatchPool.all.each do |mp|
      scores = Bet.select('SUM(points) total, user_id')
        .where(match_pool: mp)
        .where('points is not null')
        .group('user_id')

      scores.each do |s|
        Participant.create(
          user_id: s.user_id,
          match_pool_id: mp.id,
          points: s.total
        )
      end
    end
  end

  def down
    drop_table :participants
  end
end
