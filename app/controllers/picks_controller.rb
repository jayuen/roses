class PicksController < ApplicationController
  def update
    Pick.find(params[:id]).update_attributes! params[:pick]
    render json: {}
  end
end
