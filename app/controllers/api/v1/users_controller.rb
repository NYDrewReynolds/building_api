class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  respond_to :json, :xml

  def index
    respond_with User.all
  end

  def show
    respond_with User.find_by(id: params[:id])
  end

  def create
    respond_with User.create(user_params)
  end

  def update
    respond_with User.update(params[:id], user_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def authenticate
    authenticate_or_request_with_http_basic('Please authenticate to use our API.') do |email, password|
      user = User.find_by(email: email)

      return true if user && user.authenticate(password)

      head :unauthorized
    end
  end
end
