require 'rails_helper'

describe Api::V1::ProductsController, type: :controller do

  before {@user = FactoryBot.build :user}

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

    it "has the user as a embede object" do
      product_response = JSON.parse(response.body, symbolize_names:true)
      expect(product_response[:product][:user][:email]).to eql @product.user.email
    end

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

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryBot.create :user
        @product_attributes = FactoryBot.attributes_for :product
        api_authorization_header user.auth_token
        post :create, params: {uesr_id: user.id, product: @product_attributes}
      end

      it "renders the json representation for the product record just created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql @product_attributes[:title]
      end

      it {expect(response).to have_http_status(201)}
    end

    context "when is not created" do
      before(:each) do
        user = FactoryBot.create :user
        @invalid_product_attributes = {title: "Smart TV", price: "Twelve dollars"}
        api_authorization_header user.auth_token
        post :create, params: {user_id: user.id, product: @invalid_product_attributes}
      end

      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on where the user could not be created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it {expect(response).to have_http_status(422)}
    end
  end

  describe "PUT/PUSH #update" do
    before(:each) do
      @user = FactoryBot.create :user
      @product = FactoryBot.create :product, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: {user_id: @user.id, id: @product.id,
                                product: {title: "An expemsive TV"}}
      end

      it "renders ths json representation for the updated user" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql "An expemsive TV"
      end

      it {expect(response).to have_http_status(200)}
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: {user_id: @user.id, id: @product.id,
                                product: {price: "two yuan"}}
      end

      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names:true)
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it {expect(response).to have_http_status(422)}
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryBot.create :user
      @product = FactoryBot.create :product, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: {user_id: @user.id, id: @product.id}
    end

    it{expect(response).to have_http_status(204)}
  end

end
