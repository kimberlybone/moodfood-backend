class RecipeIngredientsController < ApplicationController
  def index
    render json: RecipeIngredient.all
  end

  def show
    render json: RecipeIngredient.find(params[:id])
  end
end
