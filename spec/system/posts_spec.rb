require 'rails_helper'

RSpec.describe "投稿管理", type: :system do
  let!(:user) { create(:user) }

  before do
    login(user)
  end

  describe '投稿操作' do
    it 'ユーザーが新しい投稿を作成できること' do
      visit new_post_path
      fill_in 'タイトル', with: 'Sample Post Title'
      fill_in 'コメント', with: 'テストです'
      select '北海道', from: 'post_production_area'
      attach_file('post[images][]', Rails.root.join('spec/fixtures/files/dummy2.jpg'))
      click_button '投稿する'
      expect(page).to have_content('投稿が作成されました！')
      expect(page).to have_content('Sample Post Title')
      expect(page).to have_content('テストです')
      expect(page).to have_content('北海道')
    end

    it 'ユーザーが投稿を削除できること' do
      post = create(:post, user: user)
      visit post_path(post)
    
      find('.fas.fa-trash-alt').click
    
      expect(current_path).to eq(posts_path)
      expect(page).to have_content('投稿が削除されました。')
      expect(page).to_not have_content(post.title)
    end                
  end
end


