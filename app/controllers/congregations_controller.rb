class CongregationsController < ApplicationController

  before_action :authorize, :dissolve, only: [:index]

  def index
    @congregations = Congregation.includes( speakers: [:talks] ).filter_by(params.slice(:search_for, :status))
  end

  def new
    @congregation = Congregation.new
    @allow_home = true if @congregation.home? or Congregation.home.blank?
  end

  def create
    @congregation = Congregation.new(cong_params)
    @allow_home = true if @congregation.home? or Congregation.home.blank?
    if @congregation.save
      redirect_to @congregation
    else
      render 'new'
    end
  end

  def show
    @congregation = Congregation.find(params[:id])
    @speakers = @congregation.speakers
    @notes = @congregation.notes
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @congregation = Congregation.find(params[:id])
    @allow_home = true if @congregation.home? or Congregation.home.blank?
  end

  def update
    @congregation = Congregation.find(params[:id])
    @allow_home = true if @congregation.home? or Congregation.home.blank?
    if @congregation.update(cong_params)
      redirect_to @congregation
    else
      render 'edit'
    end
  end

  private

  def cong_params
    params.require(:congregation).permit!
  end

end
