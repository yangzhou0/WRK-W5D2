# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :moderator_id, presence:true
  
  belongs_to :moderator,
  foreign_key: :moderator_id,
  primary_key: :id,
  class_name: :User
  
  # has_many :posts,
  # foreign_key: :sub_id,
  # primary_key: :id,
  # class_name: :Post
  
  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :post_subs
  
end
