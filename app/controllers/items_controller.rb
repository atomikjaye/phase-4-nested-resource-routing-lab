class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end
  
  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end
  
  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private
  def item_params
    # params.permit(:name, :description, :price, :user_id)
    params.permit(:name, :description, :price)
  end

  # t.string "name"
  # t.string "description"
  # t.integer "price"
  # t.integer "user_id", null: false
  # t.datetime "created_at", precision: 6, null: false
  # t.datetime "updated_at", precision: 6, null: false
  # t.index ["user_id"], name: "index_items_on_user_id"


  def not_found_error
    render json: {error: "Not Found"}, status: :not_found
  end

end
