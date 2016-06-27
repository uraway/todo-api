module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/signup
    def create
      User.transaction do
        @user = User.new(user_params)
        @user.save!
      end
      render json: @user, status: :ok
    rescue => e
      invalid_signup_attempt
    end

    private

    def user_params
      return nil if params[:user].blank?
      params.require(:user).permit(:email, :password)
    end

    def invalid_signup_attempt
      render json: {error: t('devise.failure.invalid')}, status: :unprocessable_entity
    end
  end
end
