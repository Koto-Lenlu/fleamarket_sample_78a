class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  
  def index
    @items = Item.includes(:item_images).order('created_at DESC').limit(4)
    
  end

  def new
    @item = Item.new
    @item.item_images.new

    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else 
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :category_id,
      :condition_id, :prefecture_id, :shipping_charge_id, :shipping_day_id, 
      :brand, :buyer_id, :seller_id, item_images_attributes: [:image]).merge(seller_id: current_user.id, user_id: current_user.id)
  end
end