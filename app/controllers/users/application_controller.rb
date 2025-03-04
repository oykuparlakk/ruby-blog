module Users
  class ApplicationController < ::ApplicationController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :email, :password, :password_confirmation ])
    end
  end
end
