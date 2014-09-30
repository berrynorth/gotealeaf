class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_creator, only: [:edit, :update]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by {|p| p.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  # show post form
  def new
    @post = Post.new
  end

  # handle post form submission
  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was successfully created."
      redirect_to posts_path
    else
      render :new
    end
  end

  # display edit post form
  def edit; end

  # handle edit post form submission
  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was successfully updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Vote counted!"
        else
          flash[:error] = "You can only vote once per post."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    deny_access unless logged_in? && (current_user == @post.creator || current_user.admin?)
  end
end
