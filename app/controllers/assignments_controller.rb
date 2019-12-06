class AssignmentsController < ApplicationController

  before_action :dissolve, only: [:index]
  before_action :authorize

  def index
    @assignments = Assignment.find_within(params[:starting], params[:ending])
  end

  def show
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      flash[:success] = "Assignment created!"
      redirect_to :assignments
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  private

  def assignment_params
    params.require(:assignment).permit!
  end
end
