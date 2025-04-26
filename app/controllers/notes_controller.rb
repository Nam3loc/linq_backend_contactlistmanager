class NotesController < ApplicationController
  before_action :set_contact
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_request!, if: -> { request.format.json? }

  def index
    @notes = @contact.notes

    respond_to do |format|
      format.html # renders index.html.erb
      format.json { render json: @notes } # renders JSON data
    end
  end

  def new
    @note = @contact.notes.new
  end

  def create
    @note = @contact.notes.new(normalized_note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to contact_path(@contact), notice: "Note created." }
        format.json { render json: @note, status: :created }
      else
        format.html { render :new }
        format.json { render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update(normalized_note_params)
        format.html { redirect_to contact_path(@contact), notice: "Note updated." }
        format.json { render json: @note }
      else
        format.html { render :edit }
        format.json { render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to contact_path(@contact), notice: "Note deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def set_note
    @note = @contact.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:body)
  end

  def normalized_note_params
    if request.format.json?
      raw = params.permit(:body, :note_body, :note_text)
      { body: raw[:body] || raw[:note_body] || raw[:note_text] }
    else
      note_params
    end
  end
end
