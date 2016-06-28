module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/users
    # Creates an user
    def create
      @user = User.new user_params
      if @user.save
        render json: @user, serializer: V1::SessionSerializer
      else
        render json: { error: t('devise.failure.invalid') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
