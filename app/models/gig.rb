class Gig < ApplicationRecord
  belongs_to :freelancer, class_name: "User", foreign_key: :user_id

  validates :title,       presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :price_cents, numericality: { only_integer: true, greater_than: 0 }

  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(q) do
    where("LOWER(title) LIKE ?", "%#{q.downcase}%") if q.present?
  end
end
