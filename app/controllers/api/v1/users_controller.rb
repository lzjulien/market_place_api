module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json
      def show
        # respond_with User.find(params[:id])
        # render json: { hello: 'Hello there!' }
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: 201
        else
          render json: {errors: user.errors}, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

    end
  end
end


