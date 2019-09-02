class AssembliesController < ApplicationController
  def new
    @talk = Talk.assembly.new
  end

  def create
    @talk = Talk.assembly.new(assembly_params)
    if @talk.save
      redirect_to talks_path
    else
      render 'new'
    end
  end

  private

  def assembly_params
    params.require(:talk).permit(:date, :assembly)
  end
end
