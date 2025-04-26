class AuthController < ApplicationController
  skip_before_action :authenticate_request!, only: [:login, :register]
  skip_before_action :verify_authenticity_token, only: [:login, :register]

  # Login action
  def login
    user = User.find_by(email: params[:email])

    if user.nil?
      Rails.logger.error "User not found with email: #{params[:email]}"
      render json: { error: "Invalid email or password" }, status: :unauthorized
      return
    end

    if user.authenticate(params[:password])
      payload = { user_id: user.id, exp: 5.minutes.from_now.to_i }
      token = encode_token(payload)

      cookies[:jwtToken] = {
        value: token,
        expires: 5.minutes.from_now,
        httponly: true,
        secure: Rails.env.production?
      }

      render json: { message: 'Login successful' }, status: :ok
    else
      Rails.logger.error "Invalid password for email: #{params[:email]}"
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # Register action
  def register
    if User.exists?(email: params[:email])
      return render json: { error: 'Email already taken' }, status: :unprocessable_entity
    end

    user = User.new(user_params)

    if user.save
      payload = { user_id: user.id, exp: 1.minute.from_now.to_i }
      token = encode_token(payload)

      cookies[:jwtToken] = {
        value: token,
        expires: 5.minute.from_now,
        httponly: true,
        secure: Rails.env.production?
      }

      render json: { message: 'Registration successful' }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
