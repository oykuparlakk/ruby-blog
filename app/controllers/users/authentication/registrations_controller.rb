module Users
  module Authentication
    class RegistrationsController < Devise::RegistrationsController
      before_action :configure_sign_up_params, only: [ :create ]
      before_action :configure_account_update_params, only: [ :update ]
      layout :determine_layout

      def show
      end

      private

      def determine_layout
        if %w[edit show].include?(action_name)
          "application"
        else
          "devise"
        end
      end

      private

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
      end

      def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name ])
      end

      protected

      def update_resource(resource, params)
        if params[:password].blank? && params[:password_confirmation].blank?
          resource.update_without_password(params.except(:current_password))
        else
          if params[:current_password].present? && resource.valid_password?(params[:current_password])
            resource.update(params.except(:current_password))
          else
            resource.errors.add(:current_password, :invalid)
            false
          end
        end
      end


      def after_update_path_for(resource)
        user_profile_path
      end
    end
  end
end
