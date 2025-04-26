class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery unless: -> { request.format.json? }

  def authenticate_request!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  def current_user
    return nil unless auth_header

    token = auth_header.split(' ')[1]
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      @current_user ||= User.find_by(id: decoded[0]['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end
  end

  def auth_header
    request.headers['Authorization']
  end
end
