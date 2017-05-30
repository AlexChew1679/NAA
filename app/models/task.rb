class Task < ApplicationRecord
  validates :content, presence: true, length: {minimum: 5, maximum: 100}

  belongs_to :user
end
