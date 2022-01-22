class Message < ApplicationRecord
  belongs_to :relationship, optional: true

  validates :content, presence: true
end
