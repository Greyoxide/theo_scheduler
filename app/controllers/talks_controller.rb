class TalksController < ApplicationController

  before_action :authorize

  def index

    if params.has_key?(:starting) and params.has_key?(:ending)
      @talks = Talk.find_within( params[:starting], params[:ending] )
      print "date within"

    elsif params.has_key?(:starting) and params[:ending].blank?
      @talks = Talk.where('date >= ?', params[:starting]).order(:date)

    else
      @talks = Talk.where('date >= ?', Date.today).order(:date)
    end

    respond_to do |format|
      format.html
      format.pdf do
          pdf = TalksPdf.new(@talks, view_context)
          send_data pdf.render, filename: "Talk_Schedule.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy
    redirect_to [:talks]
  end
end
