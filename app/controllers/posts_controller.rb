class PostsController < ApplicationController
  include LocationHelper

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
    @production_area = prefectures_and_countries
  end

  def create
    @post = current_user.posts.build(post_params)
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿が作成されました！'
      redirect_to @post  # 投稿が作成された後に投稿詳細ページにリダイレクト
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])  # params[:id] で指定された投稿を取得
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      flash[:notice] = '投稿が削除されました。'
    else
      flash[:alert] = '投稿が見つかりませんでした。'
    end
    redirect_to posts_path
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :production_area, images: [])
  end
end
