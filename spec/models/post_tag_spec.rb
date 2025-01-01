require 'rails_helper'

RSpec.describe PostTag, type: :model do
  it { should belong_to(:post) }
  it { should belong_to(:tag) }

  it "is invalid with a duplicate post and tag pair" do
    # テスト用のユーザーと投稿を作成
    user = create(:user)
    post = create(:post, user: user)
    tag = create(:tag, name: "example")

    # 最初のPostTagを作成
    PostTag.create!(post: post, tag: tag)

    # 同じpostとtagの組み合わせを持つPostTagを作成し、バリデーションエラーを確認
    duplicate_post_tag = PostTag.new(post: post, tag: tag)
    expect(duplicate_post_tag).to_not be_valid
    expect(duplicate_post_tag.errors[:tag_id]).to include("はすでに登録されています")
  end
end
