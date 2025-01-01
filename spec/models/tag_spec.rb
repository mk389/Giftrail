require 'rails_helper'

RSpec.describe Tag, type: :model do
  # 正常な場合
  it "is valid with a name" do
    tag = Tag.new(name: "example")  # nameを設定
    expect(tag).to be_valid         # 保存可能であることを確認
  end

  # エラーの場合
  it "is invalid without a name" do
    tag = Tag.new(name: nil)        # nameが空
    expect(tag).to_not be_valid     # 保存不可であることを確認
    expect(tag.errors[:name]).to include("を入力してください")
  end
end
