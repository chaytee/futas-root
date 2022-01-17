class Message < ApplicationRecord
<<<<<<< HEAD
=======
  belongs_to :user

  validates :content, presence: true
>>>>>>> master
end
