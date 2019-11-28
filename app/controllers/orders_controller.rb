class OrdersController < ApplicationController
  def create
    shift = Shift.find(params[:shift_id])
    order = Order.create!(shift: shift, shift_sku: shift.title, amount: (shift.total_pay * 100).to_i, state: 'pending', user: current_user)
    authorize order
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: shift.title,
        amount: (shift.total_pay * 100).to_i,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: dashboard_employer_url,
      cancel_url: dashboard_url
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
