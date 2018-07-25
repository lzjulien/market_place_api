require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  before{@user = FactoryBot.build :user}

  describe "GET #show" do
    before(:each) do
      @product = FactoryBot.create :product
      get :show, params: {id: @product.id}
    end

    it "returns the information about a reporter on a hash" do
      product_response = JSON.parse(response.body, symbolize_names: true)
      expect(product_response[:title]).to eql @product.title
    end

    it {expect(response).to have_http_status(200)}

  end

  describe "GET #index" do
    before(:each) do
      @user.save
      4.times {FactoryBot.create :product, user: @user}
      get :index
    end

    it "returns 4 records from the database" do
      product_response = JSON.parse(response.body, symbolize_names: true)
      expect(product_response).to have(4).items
    end

    # it {expect(response).to have_http_status(200)}
  end

end
