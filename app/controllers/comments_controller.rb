class CommentsController < ApplicationController
  before_action :set_article
  before_action :customized_authenticate_user!

  def create
    @comment = @article.comments.new(comments_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments",
      render(partial: 'comments/newcomment')
      flash.now[:notice] = "Comment has been created"
    else
      flash[:alert] = "Comment has not been created"
      redirect_to article_path(@article)
    end
  end

  private

    def comments_params
      params.require(:comment).permit(:body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end

    def customized_authenticate_user!
      unless current_user
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to new_user_session_path
      end
    end
end
