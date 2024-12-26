require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it 'nameが空でないこと' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid  # 期待される結果は、ユーザーが無効であること
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'residenceが空でないこと' do
      user = build(:user, residence: nil)
      expect(user).not_to be_valid  # 期待される結果は、ユーザーが無効であること
      expect(user.errors[:residence]).to include("を入力してください")
    end

    it 'name, residence, アイコンが正しく設定されていれば、ユーザーは有効であること' do
      user = create(:user)
      expect(user).to be_valid
      expect(user.icon.url).not_to be_nil
      expect(user.icon.url).to include('dummy2.jpg')
    end
  end

  describe '関連付け' do
    it 'ユーザーが削除されると、関連するポストも削除されること' do
      user = create(:user)
      post1 = user.posts.create(title: 'ポスト1', production_area: '大阪')
      post2 = user.posts.create(title: 'ポスト2', production_area: '東京')
      expect { user.destroy }.to change { Post.count }.by(-2)
    end
  end

  describe 'アイコンのアップロード' do
    it 'アイコンが正常にアップロードされること' do
      user = create(:user)
      expect(user.icon.url).not_to be_nil
      expect(user.icon.url).to include('dummy2.jpg')
    end
  end

  describe '.from_omniauth' do
    let(:auth_data) do
      OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '1234567890',
        info: {
          email: 'google_test@example.com',
          name: 'Google User',  # nameはそのまま使用
          image: 'http://example.com/google_user.png'
        }
      })
    end

    context '既存のユーザーがproviderとuidで存在する場合' do
      let!(:existing_user) { create(:user, provider: 'google_oauth2', uid: '1234567890', email: 'google_test@example.com') }

      it 'そのユーザーを返す' do
        user = User.from_omniauth(auth_data)
        expect(user).to eq(existing_user)
      end
    end

    context '既存のユーザーがメールアドレスで存在し、providerとuidがない場合' do
      let!(:existing_user) { create(:user, email: 'google_test@example.com', provider: nil, uid: nil) }

      it '既存ユーザーを更新して返す' do
        user = User.from_omniauth(auth_data)
        expect(user).to eq(existing_user)
        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('1234567890')
      end
    end

    context '該当するユーザーが存在しない場合' do
      it '新しいユーザーを作成する' do
        expect {
          user = User.from_omniauth(auth_data)
          expect(user.name).to eq('Google User')  # 期待される名前がそのまま使用される
          expect(user.icon).not_to be_nil
          expect(user.icon.url).to include('dummy2.jpg')
        }.to change { User.count }.by(1)
      end
    end
  end
end
