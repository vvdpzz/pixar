class CategoryQuestion < ActiveRecord::Base
      validates_uniqueness_of :question_id
end
