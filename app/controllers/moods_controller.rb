class MoodsController < ApplicationController
  def index
    render json: Mood.all, include: '**'
  end

  def show
    render json: Mood.find_by(name: params[:id])
  end
end
