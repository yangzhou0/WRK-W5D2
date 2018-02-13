class SubsController < ApplicationController
  before_action :ensure_moderator, only:[:edit, :update]
  before_action :require_login, only:[:new, :create]
  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      redner :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  
  end

  def update
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
