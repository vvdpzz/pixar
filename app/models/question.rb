class Question < ActiveRecord::Base
  include Extensions::UUID
  
  belongs_to :user, :counter_cache => true
  belongs_to :category, :counter_cache => true
  
  has_many :answers, :dependent => :destroy
  has_and_belongs_to_many :tags
  has_many :comments, :class_name => "Comment", :foreign_key => "pixar_id", :dependent => :destroy
  
  default_scope order("created_at DESC")

  acts_as_voteable
  
  # users that self follows
  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(:id => user_ids)
  end
  
  # number of followers
  def followers_count
    $redis.scard(self.redis_key(:followers))
  end
  
  # does the user follow self
  def followed_by?(user)
    $redis.sismember(self.redis_key(:followers), user.id)
  end
  
  # helper method to generate redis keys
  def redis_key(str)
    "question:#{self.id}:#{str}"
  end
  
  def self.strong_create_question(id, user_id, title, content, reputation, credit, is_community)
    ActiveRecord::Base.connection.execute("call sp_deduct_credit_and_money(#{id},#{user_id},\"#{title}\",\"#{content}\",#{reputation},#{credit},#{is_community})")
  end
end
