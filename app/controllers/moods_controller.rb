class MoodsController < ApplicationController
  def index
    render json: Mood.all
  end

  def show
    render json: Mood.find(params[:id])
  end
end
