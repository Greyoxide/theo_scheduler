class CongregationsController < ApplicationController

  before_action :authorize

  def index
    @congregations = Congregation.includes([:speakers]).filter_by(params.slice(:search_for, :status))
  end

  def new
    @home = Congregation.where(home: 1)
    @congregation = Congregation.new
  end

  def create
    @congregation = Congregation.new(cong_params)
    if @congregation.save
      redirect_to @congregation
    else
      render 'new'
    end
  end

  def show
    @congregation = Congregation.find(params[:id])
    @speakers = @congregation.speakers.includes([:outlines])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @home = Congregation.where(home: 1)
    @congregation = Congregation.find(params[:id])
  end

  def update
    @congregation = Congregation.find(params[:id])
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
