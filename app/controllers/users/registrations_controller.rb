class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = '登録が完了しました'
        redirect_to root_path and return # 正常な場合、リダイレクト
      else
        flash[:alert] = '登録に失敗しました'
        # フォームに戻す際、リダイレクトを追加してみてください
        redirect_to new_user_registration_path and return # 失敗時でもリダイレクト
      end
    end
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
