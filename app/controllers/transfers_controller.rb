class TransfersController < ApplicationController

	def new
		@speaker = Speaker.find(params[:speaker_id])
		@congregations = Congregation.where.not(id: @speaker.congregation.id)
	end

	def create
		@speaker = Speaker.find(params[:speaker_id])
		@congregations = Congregation.where.not(id: @speaker.congregation.id)
		if @speaker.update(transfer_params)
			redirect_to @speaker
		else
			render  :new
		end
	end

	private

	def transfer_params
		params.require(:speaker).permit(:congregation_id)
	end
end
