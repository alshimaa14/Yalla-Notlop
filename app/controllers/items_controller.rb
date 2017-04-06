class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @user = User.find(params[:user_id])
    @order = @user.orders.find(params[:order_id])
    @items = @order.items.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @user = User.find(params[:user_id])
    @order = @user.orders.find(params[:order_id])
    #redirect if order is finished
    if(!@order.waiting) 
      redirect_to user_orders_path
    end
    #redirect if user isnt invited to this order
    @invited_friends = @order.order_friend_invitations
    @invited_friends_ids = []
    @invited_friends.each do |inv| 
      @invited_friends_ids << inv.user_id.to_i
    end
    if(!(@invited_friends_ids.include? current_user.id))
      redirect_to user_orders_path
    end
    @item = @order.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.find(params[:order_id])
    @item = @order.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to [@user,@order,@item], notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to [@user,@order,@item], notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to user_order_items_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @user = User.find(params[:user_id])
      @order = @user.orders.find(params[:order_id])
      @item = @order.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item, :amount, :price, :comment, :order_id, :user_id)
    end
end
