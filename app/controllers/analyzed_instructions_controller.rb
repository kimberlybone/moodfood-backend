class AnalyzedInstructionsController < ApplicationController
  def index
    render json: AnalyzedInstruction.all
  end

  def show
    render json: AnalyzedInstruction.find(params[:id])
  end
end
