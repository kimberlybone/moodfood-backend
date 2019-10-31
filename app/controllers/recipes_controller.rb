class RecipesController < ApplicationController
  def index
    render json: Recipe.all
  end

  def show
    render json: Recipe.find(params[:id])
  end
end
