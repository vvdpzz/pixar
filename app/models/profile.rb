class Profile < ActiveRecord::Base
  include Extensions::UUID
  belongs_to :user
  
  attr_accessible :id, :description, :location, :website
end
