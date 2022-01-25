class Task < ApplicationRecord

  #has_one :relationship
  belongs_to :relationship

  validates :title, presence: true
end
