class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      create_razorpay_order(@payment)
    else
      render :new
    end
  end

  def callback
	  payment_id = params[:razorpay_payment_id]
	  payment = Payment.find_by(razorpay_payment_id: payment_id)

	  if payment.present?
	    payment.update(status: 'completed')
	    flash[:notice] = 'Payment was successful'
	  else
	    flash[:alert] = 'Payment failed'
	  end
	  redirect_to '/'
	end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def create_razorpay_order(payment)
    order = Razorpay::Order.create amount: payment.amount * 100, currency: 'INR'
    payment.update(razorpay_payment_id: order.id)
    redirect_to payments_callback_path(payment)
  end
end
