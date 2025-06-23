class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment, :order_id, :gig, :client, :created_at

  def gig
    { id: object.gig.id, title: object.gig.title }
  end

  def client
    { id: object.client.id, name: object.client.name }
  end
end
