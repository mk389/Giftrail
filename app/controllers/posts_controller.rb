class PostsController < ApplicationController
  include LocationHelper
  POST_COUNT = 15

  def index
    @query = params[:query]
    @production_area = prefectures_and_countries
  
    # 最初に全投稿を取得
    @posts = Post.all
  
    # フリーワード検索（タイトルと本文に対して検索）
    if @query.present?
      @posts = @posts.where('title LIKE :query OR body LIKE :query', query: "%#{@query}%")
    end
  
    # 絞り込み検索（production_areaに対して検索）
    if params[:production_area_eq].present?
      @posts = @posts.where(production_area: params[:production_area_eq])
    end
  
    # タグによる絞り込み
    if params[:tag].present?
      # タグが存在すれば、そのタグに関連する投稿を取得
      @tag = Tag.find_by(name: params[:tag])
      @posts = @tag.posts if @tag
    end
  
    # 投稿を作成日順に並べ、ページネーションを適用
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(POST_COUNT)
  end
  
  def new
    @post = Post.new
    @production_area = prefectures_and_countries
  end

  def create
    @post = current_user.posts.build(post_params)
    @production_area = prefectures_and_countries
    
    # タグ処理
    if params[:post][:tag_names].present?
      tags = params[:post][:tag_names].split(',').map(&:strip).uniq
      tags.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @post.tags << tag
      end
    end
  
    if @post.save
      flash[:notice] = '投稿が作成されました！'
      redirect_to @post
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = '投稿が見つかりませんでした。'
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
  
    if @post && @post.user == current_user
      @post.destroy
      flash[:notice] = '投稿が削除されました。'
    end
  
    redirect_to posts_path
  end  

  def autocomplete
    query = params[:query]
    @posts = Post.where("title LIKE ?", "%#{query}%")

    # 必要な情報（タイトル、本文、産地）をJSON形式で返す
    render json: @posts.map { |post| { title: post.title, body: post.body, production_area: post.production_area } }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :production_area, images: [], tag_names: [])
  end
end
