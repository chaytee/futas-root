class Task < ApplicationRecord

  #作成のため一時的に許可 nilでも表示される
  belongs_to :relationship, optional: true

  validates :title, presence: true
end
