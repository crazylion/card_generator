class Category < ActiveRecord::Base
  has_many :cards,:order=>"created_at desc"
  belongs_to :user
  acts_as_commentable
end
