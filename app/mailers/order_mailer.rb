class OrderMailer < ApplicationMailer

  default from: 'dhruvsharma.rq@gmail.com'
  # Called when a client places an order
  def order_confirmation(order_id)
    @order = Order.includes(:gig, :client, :freelancer).find(order_id)
    mail(
      to: "dhruvds2002@gmail.com",
      # to: @order.freelancer.email,
      subject: "New Order for Your Gig: #{@order.gig.title}"
    )
  end

  # Called when a review is submitted (optional)
  def review_submitted(review_id)
    @review = Review.includes(order: :freelancer).find(review_id)
    mail(
      to: @review.order.client.email,
      subject: "Thank You for Reviewing #{@review.gig.title}"
    )
  end
end
