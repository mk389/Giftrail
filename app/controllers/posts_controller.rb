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
      flash[:notice] = '投稿が作成されました！'
      redirect_to @post
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :prefecture, :image)
  end
end
