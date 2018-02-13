class PostsController < ApplicationController
  
  def new
    @post=Post.new()
  end

  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids:[])
  end


  def edit
  end

  def update
  end

  def show
    @post = Post.find(params[:id])
    
  end

  def destroy
  end
end
