module MatchPoolsHelper

  def matches_with_bets_for user, future=true
    if user.bets_for(@match_pool).count > 0
      matches = Match.select('
        matches.id,
        matches.home_team_id,
        home.name home_team_name,
        matches.away_team_id,
        away.name away_team_name,
        matches.when,
        matches.home,
        matches.away,
        bets.home user_home,
        bets.away user_away,
        bets.points user_points
      ').joins('JOIN bets ON bets.match_id = matches.id')
      .joins('JOIN teams home ON matches.home_team_id = home.id')
      .joins('JOIN teams away ON matches.away_team_id = away.id')
      .where(match_pool: @match_pool).where('bets.user_id = ?', user.id)
      .order(when: :asc, id: :asc)

      matches = matches.where('matches.when < ?', Time.now) unless future

      return matches
    else
      return Match.select('
        matches.id,
        matches.home_team_id,
        home.name home_team_name,
        matches.away_team_id,
        away.name away_team_name,
        matches.when,
        matches.home,
        matches.away
      ').joins('JOIN teams home ON matches.home_team_id = home.id')
      .joins('JOIN teams away ON matches.away_team_id = away.id')
      .where(match_pool: @match_pool)
      .order(when: :asc, id: :asc)
    end
  end

  def get_scoreboard
    if @match_pool.bets_opened_at
      @scoreboard = Bet.select('
        RANK() over(ORDER BY SUM(points) DESC) place,
        SUM(points) total,
        users.name, user_id
      ').joins('JOIN users ON bets.user_id = users.id').where(match_pool: @match_pool).group('users.name, user_id').limit(10).order('total DESC')
    end
  end

end
