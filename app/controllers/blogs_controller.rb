class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
      respond_to do |format|
        if @blog.valid? && params[:confirm]
          format.html { render :new_confirm }
        elsif params[:back]
          format.html { render :new }
        elsif @blog.save
          format.html { redirect_to @blog, notice: 'つぶやきが登録されました' }
          format.json { render :show, status: :created, location: @blog }
        else
          format.html { render :new }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    @blog.assign_attributes(blog_params)
    respond_to do |format|
      if @blog.valid? && params[:confirm]
        format.html { render :edit_confirm }
      elsif params[:back]
        format.html { render :edit }
      elsif @blog.save
        format.html { redirect_to @blog, notice: 'つぶやきが更新されました' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'つぶやきが削除されました' }
      format.json { head :no_content }
    end
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end
  def blog_params
      params.require(:blog).permit(:content)
  end
  
end

