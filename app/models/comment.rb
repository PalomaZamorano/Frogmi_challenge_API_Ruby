# app/models/comment.rb
class Comment < ActiveRecord::Base
    belongs_to :earthquake
  
    validates :body, presence: true
end
  