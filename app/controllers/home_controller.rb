class HomeController < ApplicationController
  def index
    @products = Product.all
    @featuring_products = @products.filter(&:featuring_product)
  end

  def about
  end
end
