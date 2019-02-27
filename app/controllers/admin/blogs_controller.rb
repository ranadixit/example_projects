class Admin::BlogsController < ApplicationController
	layout "layouts/adminapplication"

	def index
		if session[:user_id]!=nil
		    if detail=params[:blog]
		      #@blogs = Blog.connection.execute("SELECT * FROM blogs WHERE (title LIKE '%#{detail[:search]}%')")
		      @blogs=Blog.where("title LIKE ? OR description LIKE ?","%#{detail[:blog_search].capitalize}%","%#{detail[:blog_search]}%").order(update_at: :desc)
		    else
		      @blogs = Blog.all.order(update_at: :desc)
		    end
	    else
      		redirect_to login_path
   		end
  end

  def new
    if session[:user_id]!=nil
      @blog = Blog.new
    else
      redirect_to login_path
    end
  end

  def create
    @user = User.find(current_user.id)
    @blog = Blog.new(blog_params.merge(user_id: current_user.id,))
    
    if @blog.save
      flash[:success]="Blog was successfully created"
      redirect_to admin_blog_path(@blog)
    else
      render :new
    end
  end

  def show
  	if session[:user_id]!=nil
     	@blog = Blog.find(params[:id])
    else
      	redirect_to login_path
    end
  end

  def edit
    if session[:user_id]!=nil
      @blog = Blog.find(params[:id])
     else
      redirect_to login_path
    end
  end

  def update    
     @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    
    if @blog.save
      flash[:success]="Blog successfully updated"
      redirect_to admin_blog_path(@blog)
    else
      render 'edit'
    end
  end

  def destroy 
     @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:success]="Blog successfully deleted"
    redirect_to admin_blogs_path
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :description, :user_id, :department_id, :blog_image  )
  end
end