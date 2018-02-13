# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  session_token   :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :password_digest, :session_token, :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  
  has_many :comments
  
  has_many :subs,
  foreign_key: :moderator_id,
  primary_key: :id,
  class_name: :Sub
  
  has_many :posts,
  foreign_key: :author_id,
  primary_key: :id,
  class_name: :Post
  
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
end
