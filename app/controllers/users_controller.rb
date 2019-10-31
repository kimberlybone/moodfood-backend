class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  def index
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json: authentication_json(user.id)
    else
      render json: {errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
      user_id = params[:id]
      if logged_in_user_id = user_id.to_i
        user = User.find(params[:id])
        render json: user, include: "**"
      else
        render json: {go_away: true}, status: :unauthorized
      end
  end

  def update
      user = User.find(params[:id])
      user.update(user_params)
      render json: user, include: "**"
  end

  def user_params
    params.permit(:name, :email, :password, :location)
  end
end
