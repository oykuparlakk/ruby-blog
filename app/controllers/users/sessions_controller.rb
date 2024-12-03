class Users::SessionsController < Devise::SessionsController
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end
end
