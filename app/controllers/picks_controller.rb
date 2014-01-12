class PicksController < ApplicationController
  def update
    pick_params = params.require(:pick).permit(:rose, :contestant_id)
    Pick.find(params[:id]).update_attributes! pick_params
    render json: {}
  end
end
