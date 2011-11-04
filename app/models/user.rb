class User < ActiveRecord::Base
  include Extensions::UUID
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # , :registerable
  devise :token_authenticatable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :name, :email, :password, :remember_me, :authentication_token

  before_create :ensure_authentication_token
  has_one :profile
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :recharge_records
  
  acts_as_voter
  def self.basic(id)
    User.select("id,name,avatar").find_by_id(id)
  end
  
  # follow a user
  def follow_user!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:following_users), user.id)
      $redis.sadd(user.redis_key(:followers), self.id)
    end
  end

  # unfollow a user
  def unfollow_user!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:following_users), user.id)
      $redis.srem(user.redis_key(:followers), self.id)
    end
  end
  
  # follow a question
  def follow_question!(question)
    $redis.multi do
      $redis.sadd(self.redis_key(:following_questions), question.id)
      $redis.sadd(question.redis_key(:followers), self.id)
    end
  end

  # unfollow a question
  def unfollow_question!(question)
    $redis.multi do
      $redis.srem(self.redis_key(:following_quesions), question.id)
      $redis.srem(question.redis_key(:followers), self.id)
    end
  end

  # users that self follows
  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(:id => user_ids)
  end

  # users that follow self
  def following_users
    user_ids = $redis.smembers(self.redis_key(:following_users))
    User.where(:id => user_ids)
  end
  
  # questions that follow self
  def following_questions
    question_ids = $redis.smembers(self.redis_key(:following_questions))
    Question.where(:id => question_ids)
  end
  
  # does the user follow self
  def followed_by?(user)
    $redis.sismember(self.redis_key(:followers), user.id)
  end

  # does self follow user
  def following_user?(user)
    $redis.sismember(self.redis_key(:following_users), user.id)
  end

  # does self follow question
  def following_quesion?(question)
    $redis.sismember(self.redis_key(:following_questions), question.id)
  end
  
  # number of followers
  def followers_count
    $redis.scard(self.redis_key(:followers))
  end

  # number of users being followed
  def following_users_count
    $redis.scard(self.redis_key(:following_users))
  end
  
  # number of questions being followed
  def following_questions_count
    $redis.scard(self.redis_key(:following_questions))
  end
  
  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
