require "application_responder"

class ApplicationController < ActionController::Base
  after_action :verify_authorized unless :devise_controller?

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def user_not_authorized
    respond_to do |format|
      format.html { redirect_to root_url, alert: 'Access denied: You are not authorized to perform this action.' }
      format.any(:json, :js) { render nothing: true, status: :unprocessable_entity }
    end
  end
end
