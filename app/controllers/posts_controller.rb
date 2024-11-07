class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: '投稿が作成されました'
    else
      render :new, alert: '投稿に失敗しました'
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

private

  def post_params
    params.require(:post).permit(:title, :body, :prefecture, :image)  # 必要なパラメータのみ許可
  end
end
