class User < ApplicationRecord
  has_many :bets
  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true

  validates :name,
    presence: true,
    uniqueness: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = ApplicationRecord::generate_unique_secure_token()
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticate!
    update_attribute(:email_token, ApplicationRecord::generate_unique_secure_token())
    UserMailer.login(self).deliver_now
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest) == remember_token
  end

  def bets_for match_pool
    bets.where(match_pool: match_pool).order(id: :asc)
  end

  def bets_available_for match_pool
    bets_for(match_pool).select('
      bets.id,
      bets.user_id,
      bets.match_id,
      bets.home,
      bets.away,
      matches.when starts_at,
      home.name home_team_name,
      away.name away_team_name
    ').joins('JOIN matches ON bets.match_id = matches.id')
      .joins('JOIN teams home ON matches.home_team_id = home.id')
      .joins('JOIN teams away ON matches.away_team_id = away.id')
      .where('matches.when > ?', Time.now)
  end

  def score_of match_pool
    scores = bets.select('sum(points) total, user_id').where(match_pool: match_pool).group('user_id').order('total DESC')
    return scores.first.total if scores.first
    return 0
  end

end
