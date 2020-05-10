class CartsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @carts = current_user.carts
    authorize @cart
  end

  def show
    @cart = Cart.find(params[:id])
    @cart_products = @cart.cart_products
    authorize @cart
    @cart_sum = CartProduct.where(cart_id: @cart.id)
    @cart_sum = @cart_sum.group_by { |prod| prod.product_id}
  end

  def update
    @cart = Cart.find(params[:id])
    authorize @cart
    @cart.status = "closed"
    @cart.save
    redirect_to cart_path(@cart)
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :status)
  end
end
