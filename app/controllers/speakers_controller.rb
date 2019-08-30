class SpeakersController < ApplicationController

  before_action :authorize

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

  def outline_list
    @speaker = Speaker.find(params[:speaker_id])
    @ountlines = @speaker.outlines
  end

  def update_outline_list
    @speaker = Speaker.find(params[:speaker_id])
    @outlines = params[:outlines]
    @speaker.update_list(params[:outlines].split(',').map{ |o| o.to_id })
  end

  private

  def speaker_params
    params.require(:speaker).permit(:first_name, :last_name, :email, :phone, :outline_ids => [])
  end
end
