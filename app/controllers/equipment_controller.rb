class EquipmentController < ApplicationController
  def index
    render json: Equipment.all
  end

  def show
    render json: Equipment.find(params[:id])
  end
end
