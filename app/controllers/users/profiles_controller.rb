class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      if @user.update_without_password(user_params)
        redirect_to users_profile_path, notice: "Profiliniz başarıyla güncellendi."
      else
        flash.now[:alert] = "Bilgiler güncellenemedi, lütfen tekrar deneyin."
        render :edit
      end
    else
      if @user.update(user_params)
        redirect_to users_profile_path, notice: "Profiliniz başarıyla güncellendi."
      else
        flash.now[:alert] = "Bilgiler güncellenemedi, lütfen tekrar deneyin."
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
