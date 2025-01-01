require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションチェック' do
    it 'titleとproduction_areaとimagesが設定されていれば有効であること' do
      user = build(:user)
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg')
      post = build(:post, user: user, images: [file])
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end
  end
end
  