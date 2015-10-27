class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  rescue_from ActionController::RoutingError, :with => :not_found

  def not_found
    flash[:error] = t(:page_not_found)
    redirect_to root_path
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
