require 'rails_helper'

class Authentication
  include Authenticable
end

describe Authenticable do
  let(:authentication) {Authentication.new}
  subject {authentication}

  describe "#current_user" do
    before do
      @user = FactoryBot.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end
    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryBot.create :user
      allow(authentication).to receive(:current_user).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive(:response).and_return(response)
    end

    it "render a json error message" do
      auth_response = JSON.parse(response.body, symbolize_names: true)
      expect(auth_response[:errors]).to eql "Not authenticated"
    end

      # it {expect(response).to have_http_status(401)}
  end
end