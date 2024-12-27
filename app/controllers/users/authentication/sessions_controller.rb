module Users
  module Authentication
    class SessionsController < Devise::SessionsController
      layout "devise"

      def after_sign_out_path_for(resource_or_scope)
        root_path
      end
    end
  end
end
