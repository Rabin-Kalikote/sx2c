class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.article_id = @article.id

    if @comment.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
end
