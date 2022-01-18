# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  attr_accessor :invitation_digest

  has_many :messages
  has_many :tasks

  validates :name, presence: true
  validates :name, length: { maximum: 30 }

end
