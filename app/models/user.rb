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
  
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :recharge_records
  
  acts_as_voter
  def self.basic(id)
    User.select("id,name,avatar").find_by_id(id)
  end
end
