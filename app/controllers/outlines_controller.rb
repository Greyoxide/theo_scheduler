class OutlinesController < ApplicationController

	before_action :authorize

  def index
		respond_to do |format|
			format.html do
		    if params[:filter] == 'suspended'
		      @showing = "Suspended"
		      @outlines = Outline.suspended
		    else
		      @showing = "Active"
		      @outlines = Outline.active
		    end
			end
			format.js do
				@speaker = Speaker.find(params[:speaker_id])
				@outlines = @speaker.outlines
			end
		end
  end

	def show
		@outline = Outline.find(params[:id])
	end

  def new
    @outline = Outline.new
  end

  def create
    @outline = Outline.new(outline_params)
    if @outline.save
      redirect_to outlines_path
    else
      render :new
    end
  end

  def edit
    @outline = Outline.find(params[:id])
  end

  def update
    @outline = Outline.find(params[:id])
    if @outline.update(outline_params)
      redirect_to outlines_path
    else
      render :edit
    end
  end

  private

  def outline_params
    params.require(:outline).permit!
  end

end
