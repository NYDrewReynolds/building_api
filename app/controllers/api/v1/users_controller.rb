class Api::V1::UsersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with User.all
  end

  def show
    respond_with User.find_by(id: params[:id])
  end

  def create
    respond_with User.create(item_params)
  end

  def update
    respond_with User.update(params[:id], item_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :email)
  end
end
