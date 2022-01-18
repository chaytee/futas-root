# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  attr_accessor :invitation_token


  has_many :messages
  has_many :tasks

  validates :name, presence: true
  validates :name, length: { maximum: 30 }

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  #invitation_tokenのハッシュ値をデータベースへ
  def invitation
    self.invitation_token = User.new_token
    update_attribute(:invitation_digest, User.digest(invitation_token))
  end
end
