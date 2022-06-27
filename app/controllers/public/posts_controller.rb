class Public::PostsController < ApplicationController
  layout 'public/application'
  before_action :ensure_corect_member, only:[:edit]
  before_action :ensure_withdraw_member, only:[:show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment_new = PostComment.new
  end

  def index
    @posts = Post.joins(:member).where({member: {is_deleted: false}}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  # いいねが多い順
  def many_favorites
    posts = Post.includes(:favorited_members).joins(:member).where({member: {is_deleted: false}}).order(id: :desc).sort {|a,b| b.favorited_members.size <=> a.favorited_members.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to root_path
  end

  # タグに紐ずく検索結果
  def search
    @tags = Tag.limit(10)
  end

  # 男性の投稿
  def men
    @posts_men = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 0}}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  # 女性の投稿
  def women
    @posts_women = Post.joins(:member).where({member: {is_deleted: false}}).where({member: {gender: 1 }}).order(id: :desc).page(params[:page]).per(40)
    @tags = Tag.limit(10)
  end

  private
    def post_params
      params.require(:post).permit(:outfit_image, :body, :title, tag_ids: [])
    end

    def ensure_corect_member
      @post = Post.find(params[:id])
      unless @post.member == current_member
        flash[:alert] = "不正なアクセスです"
        redirect_to posts_path
      end
    end

    def ensure_withdraw_member
      post = Post.find(params[:id])
      if post.member.is_deleted == true
        flash[:alert] = "退会済みユーザーの投稿です"
        redirect_to posts_path
      end
    end
end
