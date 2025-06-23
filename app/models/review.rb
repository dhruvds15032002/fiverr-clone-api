class Review < ApplicationRecord
  belongs_to :order

  has_one :gig, through: :order
  has_one :client, through: :order, source: :client
  has_one :freelancer, through: :order, source: :freelancer

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { minimum: 5 }

  validate :order_must_be_completed

  private

  def order_must_be_completed
    return if order&.completed?
    errors.add(:order, "must be completed before review")
  end
end
