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
end
