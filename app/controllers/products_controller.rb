class ProductsController < ApplicationController
  # GET /products/:handle.html
  def show
    @product = Product.find(params[:handle])
  end
end
