class PeopleController < ApplicationController

  before_action :authorize
  before_action :dissolve, only: [:index]

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
    @assignments = @person.assignments.find_within(params[:starting], params[:ending])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:success] = "Person created"
      redirect_to @person
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
  end

  private

  def person_params
    params.require(:person).permit!
  end
end
