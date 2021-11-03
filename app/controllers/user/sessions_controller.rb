# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # 退会しているかを判断するメソッド
  def reject_user

    # 【処理1】 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    if @user
      # 【処理2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if (@user.valid_password?(params[:user][:password]) && (@user.is_deleted == true))
        # 【処理3】
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
