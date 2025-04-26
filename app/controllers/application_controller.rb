class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery unless: -> { request.format.json? }

  before_action :authenticate_request!

  private

  def authenticate_request!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  def current_user
    token = cookies[:jwtToken]

    return nil if token.blank?

    # Decode the JWT token
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      
      if decoded[0]['exp'] < Time.now.to_i
        return nil
      end

      # Find the user from the decoded token
      @current_user ||= User.find_by(id: decoded[0]['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end
  end
end
