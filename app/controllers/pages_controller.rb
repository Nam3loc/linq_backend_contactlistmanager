class PagesController < ApplicationController
  skip_before_action :authenticate_request!, only: [:jwt_client]

  def jwt_client
  end
end
