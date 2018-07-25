class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def index
    @productall = Product.all
    render json: @productall
  end
end
