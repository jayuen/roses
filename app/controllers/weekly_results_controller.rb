class WeeklyResultsController < ApplicationController
  def update
    weekly_result_params = params.require(:weekly_result).permit(:rose_order, :contestant_id, :rose)
    WeeklyResult.find(params[:id]).update_attributes! weekly_result_params
    render json: {}
  end
end
