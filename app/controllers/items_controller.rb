class ItemsController < ApplicationController
  before_action :authenticate
  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: "The item was created."
    else
      flash.now[:notice] = "The item was not created."
      render :edit
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(item_params)
      redirect_to item_path(@item), notice: "The item was updated."
    else
      flash.now[:notice] = "The item was not updated."
      render :edit
    end
  end

  def destroy
    Item.destroy(params[:id])

    redirect_to items_path, notice: "The item was deleted."
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
