class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
   
    @purchase = Payment.where(user_id: current_user.id).last
    @product = Product.find(@purchase.product_id)
  end

  def webhook
   
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id

   
    trans = Payment.create(
      user_id: user_id,
      product_id: listing_id,
      stripe_transaction_id: payment_id
    )

    purchase_status = Product.find(listing_id)
    purchase_status.update(purchased: true)
    purchase_status.save
    link_to failure_payment_path unless trans
  end
end
