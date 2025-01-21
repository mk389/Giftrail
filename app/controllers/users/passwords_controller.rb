module Users
  class PasswordsController < Devise::PasswordsController
    # パスワードリセットフォームの表示
    def new
      super
    end

    # パスワードリセット処理
    def create
      super
    end

    # パスワードの更新処理
    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      
      if resource.errors.empty?
        set_flash_message!(:notice, :updated_not_active)
        redirect_to new_session_path(resource_name) # ログイン画面にリダイレクト
      else
        respond_with resource
      end
    end
  end
end
