class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(sanitized_params)
    # Redo form if bad inputs:
    unless @product.name.length > 0
      flash[:alert] = "You must name the product."
      render :new
      return
    end
    unless @product.price && @product.price > 0
      flash[:alert] = "No freebies!"
      @product.price = nil # delete bad user set value if necessary
      render :new
      return
    end
    # Set defaults
    unless @product.tax
      @product.normal_tax!
    end
    # Set product to available
    @product.available!
    redirect_to products_url
  end

private

  def sanitized_params
    params.require(:product).permit(:name, :description, :price, :tax)
  end

end
