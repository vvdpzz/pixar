class Question < ActiveRecord::Base
  include Extensions::UUID
  
  belongs_to :user, :counter_cache => true
  belongs_to :category, :counter_cache => true
  
  has_many :answers, :dependent => :destroy
  has_many :comments, :class_name => "Comment", :foreign_key => "pixar_id", :dependent => :destroy
  
  default_scope order("created_at DESC")

  acts_as_voteable
end
