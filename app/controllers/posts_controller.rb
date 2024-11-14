class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    if current_user.nil?
      flash[:alert] = 'ログインしてください。'
      redirect_to new_post_path
      return
    end

    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      # 画像がアップロードされた場合
      if params[:post][:image].present?
        @post.image.attach(params[:post][:image])
      end

      flash[:notice] = '投稿が作成されました！'
      redirect_to @post  # 投稿が作成された後にその投稿詳細ページにリダイレクト
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])  # params[:id] で指定された投稿を取得
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :prefecture, :image)
  end
end
