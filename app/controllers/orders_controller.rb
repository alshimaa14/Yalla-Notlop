class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  # GET /orders
  # GET /orders.json
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @user = User.find(params[:user_id])
    @order = @user.orders.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to new_user_order_order_friend_invitation_path(@user, @order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to [@user,@order], notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to user_orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def finish
    @user = User.find(params[:user_id])
    @order = @user.orders.find(params[:order_id])
    @order.update_attribute(:waiting, false)
    #render plain: @order.inspect
    redirect_to user_orders_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @user = User.find(params[:user_id])
      @order = @user.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:meal, :resturant_name, :user_id, :menu)
    end
end
