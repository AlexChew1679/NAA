class Task < ApplicationRecord
  validates :content, presence: true, length: {minimum: 5, maximum: 100}


  # validates_attachment :image, presence: true ,
  # content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
  # message: 'Only Images allowed'
  #
  # validates_attachment :resource, presence: true,
  # content_type: { content_type: "application/pdf" },
  # message: 'Only PDF allowed '



  belongs_to :user
  has_attached_file :image
  has_attached_file :resource
end
