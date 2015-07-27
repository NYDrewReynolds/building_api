class OrdersController < ApplicationController
  respond_to :html, :json, :xml
  def index
    @orders = Order.all

    respond_with @orders
  end

  def show
    @order = Order.find(params[:id])

    respond_with @order
  end
end
