class SpeakersController < ApplicationController

  def index
    respond_to do |format|
      format.js do
        @congregation = Congregation.find(params[:congregation_id])
        @speakers = @congregation.speakers
      end
    end
  end

  def show
    @speaker = Speaker.find(params[:id])
    @outlines = @speaker.outlines
  end

  def new
    @congregation = Congregation.find(params[:congregation_id])
    @speaker = @congregation.speakers.new
  end

  def create
    @congregation = Congregation.find(params[:congregation_id])
    @speaker = @congregation.speakers.new(speaker_params)
    if @speaker.save
      redirect_to @speaker
    else
      render :new
    end
  end

  def edit
    @speaker = Speaker.find(params[:id])
    @congregation = @speaker.congregation
  end

  def update
    @speaker = Speaker.find(params[:id])
    @congregation = @speaker.congregation
    if @speaker.update(speaker_params)
      redirect_to @speaker
    else
      render :edit
    end
  end

  private

  def speaker_params
    params.require(:speaker).permit(:first_name, :last_name, :email, :phone, :outline_ids => [])
  end
end
