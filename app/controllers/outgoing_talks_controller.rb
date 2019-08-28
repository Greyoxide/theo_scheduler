class OutgoingTalksController < ApplicationController
  def index
  end

  def new
    @talk = Talk.new
    @home = Congregation.home
    @speakers = @home.speakers.includes(:outlines)
    @congregations = Congregation.where(home: [false, nil])
  end

  def create
    @talk = Talk.new(outgoing_talk_params)
    @home = Congregation.home
    @speakers = @home.speakers.includes(:outlines)
    @congregations = Congregation.where(home: [false, nil])
    if @talk.save
      redirect_to talks_path
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def outgoing_talk_params
    params.require(:talk).permit!
  end
end
