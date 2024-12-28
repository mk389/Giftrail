class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])  # タグ名で検索
    if @tag
      @posts = @tag.posts  # タグに関連する投稿を取得
    else
      redirect_to root_path, alert: "タグが見つかりません。"
    end
  end
end
