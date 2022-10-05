# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def show; end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :full_name,
      :email,
      :password_digest
    )
  end
end
