class PicksController < ApplicationController
  def update
    puts params[:pick]
    render json: {}
  end
end
