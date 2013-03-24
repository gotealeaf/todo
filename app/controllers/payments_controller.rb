class PaymentsController < ApplicationController
  def create
    Stripe.api_key = "sk_test_HPAHbztfQXof4GiaKA3cJiEd"

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => 3000,
        :currency => "usd",
        :card => token
      )
      flash[:success] = "Thank you for your generous support!"
      redirect_to new_payment_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
