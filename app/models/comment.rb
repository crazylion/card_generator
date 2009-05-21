class Comment < ActiveRecord::Base
  belongs_to :user
  named_scope :recent,:order=>"created desc"
  validates_presence_of     :comment
end
