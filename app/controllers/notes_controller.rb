class NotesController < ApplicationController
  
  before_action :load_notable
  
  def new
    @note = @notable.notes.new
  end

  def create
    @note = @notable.notes.new(note_params)
    if @note.save
      redirect_to @notable
    else
      render :new
    end
  end


  def edit
    @note = Note.find(params[:id])
    @notable = @note.notable
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to @notable
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to @notable
  end

  private

  def load_notable
    resource, id = request.path.split('/')[1,2]
    @notable = resource.singularize.classify.constantize.find(id)
  end

  def note_params
    params.require(:note).permit!
  end
end
