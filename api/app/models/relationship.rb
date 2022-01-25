class Relationship < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :messages

  validates :paircode, presence: true

end
