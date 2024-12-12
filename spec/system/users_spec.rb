require 'rails_helper'

RSpec.describe "ユーザー管理", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) do
    {
      user_name: 'テストユーザー',
      email: 'test@gmail.com',
      residence: '東京都',
      password: 'password123',
      password_confirmation: 'password123',
      profile_image: Rails.root.join('spec/fixtures/files/dummy2.jpg')
    
    }
  end

  describe "ユーザー新規登録" do
    context "フォームの入力値が正常" do
      it "登録成功" do
        visit new_user_registration_path # ユーザー登録ページに移動
        fill_in 'ユーザー名', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'test@gmail.com'
        select '東京都', from: 'user_residence'
        fill_in 'パスワード', with: 'password123'
        fill_in 'パスワード確認', with: 'password123'
        attach_file 'プロフィール画像', Rails.root.join('spec/fixtures/files/dummy2.jpg')
        click_on 'アカウント登録'

        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end
end