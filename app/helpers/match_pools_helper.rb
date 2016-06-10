module MatchPoolsHelper

  def matches_with_bets_for user
    if user.bets_for(@match_pool).count > 0
      return Match.select('
        matches.id,
        matches.home_team_id,
        matches.away_team_id,
        matches.when,
        matches.home,
        matches.away,
        bets.home user_home,
        bets.away user_away,
        bets.points user_points
      ').joins('JOIN bets ON bets.match_id = matches.id')
      .where(match_pool: @match_pool).where('bets.user_id = ?', user.id)
      .order(when: :asc, id: :asc)
    else
      return @match_pool.matches.order(when: :asc)
    end
  end

  def get_scoreboard
    if @match_pool.bets_closed_at
      @scoreboard = Bet.select('
        RANK() over(ORDER BY SUM(points) DESC) place,
        SUM(points) total,
        users.name, user_id
      ').joins('JOIN users ON bets.user_id = users.id').where(match_pool: @match_pool).group('users.name, user_id').limit(10).order('total DESC')
    end
  end

end
