class IncomingTalksController < ApplicationController


  before_action :authorize

  def index
  end

  def new
    @congregations = Congregation.includes(:speakers, [speakers: :outlines])
    @talk = Talk.incoming.new
    @groups = Group.all
    @selected_group = Group.next_in_rotation
    @next_date = Talk.next_date
  end

  def create
    @congregations = Congregation.includes(:speakers, [speakers: :outlines])
    @talk = Talk.incoming.new(incoming_talk_params)
    @groups = Group.all
    @selected_group = Group.next_in_rotation
    @next_date = Talk.next_date
    if @talk.save
      redirect_to talks_path
    else
      render :new
    end
  end

  def edit
  end

  private

  def incoming_talk_params
    params.require(:talk).permit!
  end
end
