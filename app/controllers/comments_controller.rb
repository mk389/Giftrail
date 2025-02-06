class CommentsController < ApplicationController
  before_action :set_post, only: [:index, :create]

  def index
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_comments_path(@post), notice: "コメントが投稿されました。"
    else
      render :index
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
