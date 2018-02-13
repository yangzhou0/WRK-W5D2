# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  content    :string
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  
  validates :title, :url, :author_id, presence:true
  
  belongs_to :author,
  foreign_key: :author_id,
  primary_key: :id,
  class_name: :User
  
  # belongs_to :sub,
  # foreign_key: :sub_id,
  # primary_key: :id,
  # class_name: :Sub
  
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments
end
