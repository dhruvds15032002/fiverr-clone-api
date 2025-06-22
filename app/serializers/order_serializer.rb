class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :price, :gig, :client, :freelancer, :created_at

  def price
    object.price_cents.to_f / 100
  end

  def gig
    {
      id: object.gig&.id,
      title: object.gig&.title
    }
  end

  def client
    { id: object.client&.id, name: object.client&.name }
  end

  def freelancer
    { id: object.freelancer&.id, name: object.freelancer&.name }
  end
end
