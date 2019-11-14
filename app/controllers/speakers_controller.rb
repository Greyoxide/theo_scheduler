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
    @talks = @speaker.talks
    @notes = @speaker.notes
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
    @outlines = @speaker.outlines.map{ |o| o.number }.join(", ")
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

  def delete
    @speaker = Speaker.find(params[:id])
    @congregation = @speaker.congregation
    @speaker.destroy
    redirect_to @congregation
  end

  private

  def speaker_params
    params.require(:speaker).permit(:full_name, :email, :phone, :outline_list)
  end
end
