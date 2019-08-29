class OutlinesController < ApplicationController

	before_action :authorize

  def index
    @speaker = Speaker.find(params[:speaker_id])
    @outlines = @speaker.outlines
  end

  def show
    @outline = Outline.find(params[:id])
  end
end
