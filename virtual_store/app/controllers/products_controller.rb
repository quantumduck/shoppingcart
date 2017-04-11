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
    unless @product.price > 0
      flash[:alert] = "No freebies!"
      render :new
    end
    # Set defaults
    unless @product.tax
      @product.normal_tax!
    end
    # Set product to available
    @product.available!
  end

private

  def sanitized_params
    params.require(:product).permit(:name, :description, :price, :tax)
  end

end
