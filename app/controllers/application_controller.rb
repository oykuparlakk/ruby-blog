class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
