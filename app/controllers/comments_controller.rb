class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_saveefore_action :set_post
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
  
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "コメントを投稿しました" }
      end
    else
      flash[:alert] = "コメントの投稿に失敗しました"
      redirect_to @post
    end
  end
  
  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "コメントを削除しました" }
      end
    else
      flash[:alert] = "削除できません"
      redirect_to @post
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