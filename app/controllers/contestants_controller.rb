class ContestantsController < ApplicationController
  def update
    contestants_params = params.require(:contestant).permit(:eliminated)
    Contestant.find(params[:id]).update_attributes! contestants_params
    render json: {}
  end
end
