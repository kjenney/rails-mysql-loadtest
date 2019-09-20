class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    @supplier.save
    redirect_to @supplier
  end
end

private
  def supplier_params
    params.require(:supplier).permit(:name)
  end
