class PostSub < ApplicationRecord
  belongs_to :sub
  belongs_to :post
  
  validates :sub, uniqueness: {scope: :post}
end