class GigSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :freelancer

  def price
    object.price_cents.to_f / 100
  end

  def freelancer
    {
      id:    object.freelancer.id,
      name:  object.freelancer.name,
      email: object.freelancer.email
    }
  end
end
