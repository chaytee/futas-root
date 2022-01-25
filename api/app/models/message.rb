class Message < ApplicationRecord

  #has_one :relationship
  belongs_to :relationship

  validates :content, presence: true
end
