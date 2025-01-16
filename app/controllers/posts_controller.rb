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
    @post.ratings.build
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
      # 評価を保存する
      if params[:post][:rating].present?
        rating_value = params[:post][:rating].to_f
        @post.ratings.create(user: current_user, rating_value: rating_value)
      end
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

  def edit
    @post = Post.find(params[:id])
    @production_area = prefectures_and_countries
  end

  def update
    @post = Post.find(params[:id])
    @production_area = prefectures_and_countries
  
    # タグの更新処理
    if params[:post][:tag_names].present?
      tags = params[:post][:tag_names].split(',').map(&:strip).uniq
      @post.tags = tags.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
    else
      @post.tags.clear # タグ入力が空の場合は既存タグをクリア
    end
  
    # 評価の更新処理
    if params[:post][:rating_value].present?
      rating_value = params[:post][:rating_value].to_f
      # もし既に評価がある場合、評価を更新
      if @post.ratings.exists?
        @post.ratings.first.update(rating_value: rating_value)
      else
        # 評価がなければ新規に作成
        @post.ratings.create(rating_value: rating_value)
      end
    end
  
    # 投稿の更新処理
    if @post.update(post_params)
      flash[:notice] = '投稿が更新されました！'
      redirect_to @post
    else
      flash.now[:alert] = '投稿の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿が削除されました"
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
