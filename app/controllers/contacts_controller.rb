class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]
  before_action :authenticate_request!

  def index
    @contacts = current_user.contacts

    if params[:search_by_name] && params[:search_by_name] != ""
      @contacts = @contacts.where("name like ?", "%#{params[:search_by_name]}%")
    end
    if params[:search_by_email] && params[:search_by_email] != ""
      @contacts = @contacts.where("email like ?", "%#{params[:search_by_email]}%")
    end

    respond_to do |format|
      format.html
      format.json { render json: @contacts }
    end
  end

  def show
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @contact }
    end
  end

  def new
    @contact = current_user.contacts.new
    @contact.notes.build
  end

  def create
    @contact = current_user.contacts.new(contact_params)
  
    if @contact.save
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      puts @contact.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contact = current_user.contacts.find(params[:id])
  end

  def update
    @contact = current_user.contacts.find(params[:id])
    if @contact.update(contact_params)
      redirect_to @contact, notice: 'Contact was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    redirect_to contacts_path, notice: 'Contact was successfully deleted.'
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, notes_attributes: [:id, :body, :_destroy])
  end
end
