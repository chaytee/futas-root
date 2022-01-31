class Task < ApplicationRecord

  #has_one :relationship
  belongs_to :relationship
  # belongs_to :user

  validates :title, presence: true
end
