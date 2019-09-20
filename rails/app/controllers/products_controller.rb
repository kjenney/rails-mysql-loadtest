class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @suppliers = Supplier.all.by_name
  end

  def create
    @product = Product.new(product_params)

    @product.save
    redirect_to @product
  end
end

private
  def product_params
    params.require(:product).permit(:name, :count, :description, :supplier_id)
  end
