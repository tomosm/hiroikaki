# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  # rescue_from NotAuthorizedError, with: :reject_forbidden_request
  # def reject_forbidden_request
  #   render json: {error: 'Forbidden'}, :status => 403
  # end

  def index
    render json: { data: [] }, content_type: 'application/vnd.api+json'
  end
end
