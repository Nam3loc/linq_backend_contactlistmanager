class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]
  before_action :authenticate_request!

  def index
    @contacts = current_user.contacts  # Fetch only the contacts for the logged-in user

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
    @contact = current_user.contacts.find(params[:id])  # Only allow fetching a contact belonging to the current user

    respond_to do |format|
      format.html
      format.json { render json: @contact }
    end
  end

  def new
    @contact = current_user.contacts.new  # Create a new contact for the current user
    @contact.notes.build
  end

  def create
    @contact = current_user.contacts.new(contact_params)  # Ensure the contact belongs to the logged-in user
    if @contact.save
      render json: @contact, status: :created
    else
      render json: { error: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @contact = current_user.contacts.find(params[:id])  # Only allow editing contacts for the current user
  end

  def update
    @contact = current_user.contacts.find(params[:id])  # Ensure the contact belongs to the logged-in user
    if @contact.update(contact_params)
      render json: @contact, status: :ok
    else
      render json: { error: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])  # Ensure the contact belongs to the logged-in user
    @contact.destroy
    head :no_content
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])  # Ensure the contact belongs to the logged-in user
  end

  def contact_params
    params.require(:contact).permit(:name, :email, notes_attributes: [:body])
  end
end
