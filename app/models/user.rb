class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  
  has_many :gigs
  has_many :orders_as_client,     class_name: "Order", foreign_key: :client_id,     dependent: :destroy
  has_many :orders_as_freelancer, class_name: "Order", foreign_key: :freelancer_id, dependent: :destroy
  
  enum role: { client: 0, freelancer: 1, admin: 2 }

  validates :name, presence: true
end
