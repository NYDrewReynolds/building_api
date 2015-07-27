class Api::V1::ItemsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def create
    respond_with Item.create(item_params)
  end

  def update
    respond_with Item.update(params[:id], item_params)
  end

  def destroy
    respond_with Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end

  def authenticate
    authenticate_or_request_with_http_basic('Please authenticate to use our API.') do |email, password|
      user = User.find_by(email: email)

      return true if user && user.authenticate(password)

      head :unauthorized
    end
  end
end
