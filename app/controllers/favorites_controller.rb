class FavoritesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
      
    respond_to do |format|
      if favorite.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("post_#{post.id}_favorite", partial: 'posts/favorite', locals: { post: post })
        end
          format.html { redirect_to post_path(post) }  # HTML fallback (Turboなし)
        else
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash", locals: { alert: "お気に入りの追加に失敗しました。" })
          end
          format.html { redirect_to post_path(post), alert: 'お気に入りの追加に失敗しました。' }
        end
      end
    end
  
    def destroy
      favorite = current_user.favorites.find_by(post_id: params[:post_id])
      post = Post.find(params[:post_id])
      
      respond_to do |format|
        if favorite&.destroy
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("post_#{post.id}_favorite", partial: 'posts/favorite', locals: { post: post })
          end
          format.html { redirect_to post_path(post) }  # HTML fallback (Turboなし)
        else
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash", locals: { alert: "お気に入りの削除に失敗しました。" })
        end
          format.html { redirect_to post_path(post), alert: 'お気に入りの削除に失敗しました。' }
        end
      end
    end
  
    private
  
  def require_login
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to new_user_session_path, alert: 'この操作を行うにはログインが必要です。' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash", locals: { alert: "この操作を行うにはログインが必要です。" }) }
      end
    end
  end
end
  