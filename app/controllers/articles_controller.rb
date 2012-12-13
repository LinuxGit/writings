class ArticlesController < ApplicationController
  before_filter :require_logined
  before_filter :find_book

  def new
    @article = @book.articles.new
    render :editor, :layout => false
  end

  def create
    @article = @book.articles.new article_params.merge(:user => current_user)
    if @article.save
      redirect_to book_article_url(@book, @article)
    else
      render :editor
    end
  end

  def show
    @article = @book.articles.find(params[:id])
    render :editor, :layout => false
  end

  private

  def find_book
    @book = current_user.books.find_by(:urlname => params[:book_id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
