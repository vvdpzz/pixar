class Answer < ActiveRecord::Base
  include Extensions::UUID
  
  belongs_to :user, :counter_cache => true, :select => [:id, :name, :avatar, :about_me, :reputation]
  belongs_to :question, :counter_cache => true
  
  has_many :comments, :class_name => "Comment", :foreign_key => "pixar_id", :dependent => :destroy
  
  default_scope order("created_at DESC")
  
  acts_as_voteable
  
  def as_json
    attributes.merge user: user
  end
  
  def self.strong_accept_answer(question_id,answer_id,asker_id,winner_id,reputation_for_winner,reputation_for_asker,credit,transaction_from_system_for_winner,transaction_from_system_for_asker)
    ActiveRecord::Base.connection.execute("call sp_answer_accept(#{question_id}, #{answer_id}, #{asker_id}, #{winner_id},#{reputation_for_winner},#{reputation_for_asker},#{credit},#{transaction_from_system_for_winner},#{transaction_from_system_for_asker}")
  end
end
