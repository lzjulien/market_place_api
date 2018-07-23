module Api
  module V1
    class UsersController < ApplicationController
      # respond_to :json
      def show
        # respond_with User.find(params[:id])
        # render json: { hello: 'Hello there!' }
        @user = User.find(params[:id])
        render json: @user
      end
    end
  end
end


