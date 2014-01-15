class ContestantsController < ApplicationController
  def update
    contestant_params = params.require(:contestant).permit(:eliminated)
    Contestant.find(params[:id]).update_attributes! contestant_params
    render json: {}
  end
end
