class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :component
  belongs_to :product_instance

  validates :note, :subject, :user_id, presence: true

  scope :drafts, where(is_draft: true)
  scope :published, where(is_draft: false)
end
