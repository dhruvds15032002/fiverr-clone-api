class Order < ApplicationRecord
  belongs_to :gig
  belongs_to :client,     class_name: "User"
  belongs_to :freelancer, class_name: "User"

  enum status: {
    pending:     0,
    accepted:    1,
    in_progress: 2,
    completed:   3,
    cancelled:   4
  }


  validates :status,    presence: true
  validates :price_cents, numericality: { only_integer: true, greater_than: 0 }

  scope :for_client,     ->(user) { where(client: user) }
  scope :for_freelancer, ->(user) { where(freelancer: user) }
  scope :recent,         -> { order(created_at: :desc) }
end
