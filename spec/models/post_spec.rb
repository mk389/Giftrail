require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションチェック' do
    it 'titleとproduction_areaが設定されていれば有効であること' do
      user = build(:user)
      post = build(:post, user: user)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end
  end
end
  