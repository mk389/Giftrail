class CommentsController < ApplicationController
  before_action :set_post, only: [:index, :create, :destroy]

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

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
        format.html { redirect_to post_comments_path(@post), notice: "コメントを削除しました" }
      end
    else
      redirect_to post_comments_path(@post), alert: "コメントを削除する権限がありません。"
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
