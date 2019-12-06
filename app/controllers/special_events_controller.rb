class SpecialEventsController < ApplicationController

  before_action :authorize

  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(special_event_params)
    if @talk.save
      redirect_to talks_path
    else
      flash[:error] = "Something went wrong, lets try this again"
    end
  end

  private

  def special_event_params
    params.require(:talk).permit(:date, :kind)
  end

end
