class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy] 
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Yazı başarıyla oluşturuldu."
      redirect_to @article
    else
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:success] = "Yazı güncellendi."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy

    @article.destroy
    flash[:danger] = "Yazı başarıyla silindi."
    redirect_to @article
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "Bu işlem için yetkiniz yok"
      redirect_to root_path
    end
  end
end