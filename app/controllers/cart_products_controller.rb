class CartProductsController < ApplicationController
skip_before_action :authenticate_user!

def create
  # se o current user não tiver cart, cart new
  # se o current user tiver e o status for fechado, criar novo cart
  # se o current user tiver cart, use o último

  if current_user.carts.empty? || current_user.carts.last.status == "closed"
    @cart = Cart.new
    @cart.user = current_user
    @cart.save
  else
    @cart = current_user.carts.last
  end
  # raise
  @cart_product = CartProduct.new
  @cart_product.cart_id = @cart.id
  @cart_product.product_id = params[:product_id]
  @cart_product.quantity.nil? ? @cart_product.quantity = 1 : @cart_product.quantity += 1
  authorize @cart_product
  if @cart_product.save
    redirect_to cart_path(@cart_product)
  else
    render 'new'
  end
end


def edit
  @cart_product = CartProduct.find(params[:id])
end

def update
  @cart_product = CartProduct.find(params[:id])
  @cart_product.update(cart_product_params)
  redirect_to shop_path(@shop)
end



def destroy
  @cart_product = CartProduct.find(params[:id])
  @cart_product.destroy
  redirect_to shops_path
end


private


def cart_products_params
  params.require(:cart_product).permit(:product_id)
end


end

