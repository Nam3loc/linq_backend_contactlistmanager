# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  # Login action (unchanged)
  def login
    user = User.find_by(email: params[:email])

    if user.nil?
      Rails.logger.error "User not found with email: #{params[:email]}"
      render json: { error: "Invalid email or password" }, status: :unauthorized
      return
    end

    if user.authenticate(params[:password])
      payload = { user_id: user.id, exp: 5.minute.from_now.to_i }
      token = encode_token(payload)
      render json: { token: token }
    else
      Rails.logger.error "Invalid password for email: #{params[:email]}"
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # Register action (new)
  def register
    # Check if the user already exists
    if User.exists?(email: params[:email])
      return render json: { error: 'Email already taken' }, status: :unprocessable_entity
    end

    # Create a new user
    user = User.new(user_params)

    if user.save
      payload = { user_id: user.id, exp: 1.minute.from_now.to_i }
      token = encode_token(payload)
      render json: { token: token }, status: :created  # Return token after successful registration
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # Permitting email, password and password_confirmation for sign up
    params.permit(:email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
