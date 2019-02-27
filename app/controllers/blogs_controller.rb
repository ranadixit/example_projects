class BlogsController < ApplicationController

  
  def index
      @departments = Department.all
      puts"...............////////////////"
      
    if detail=params[:blog]
      #@blogs = Blog.connection.execute("SELECT * FROM blogs WHERE (title LIKE '%#{detail[:search]}%')")
      @blogs=Blog.where("title LIKE ? OR description LIKE ?","%#{detail[:blog_search].capitalize}%","%#{detail[:blog_search]}%").order(update_at: :desc)
    elsif params[:department]
      @blogs = department_wish(params[:department][:department_id])
    else
      @blogs = Blog.all.order(update_at: :desc)
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
    @blog = Blog.new(params_blog.merge(user_id: current_user.id,department_id: @user.department_id))
    
    if @blog.save
      flash[:success]="Blog was successfully created"
      redirect_to @blog
    else
      render 'new'
    end
  end

  def show
     @blog = Blog.find(params[:id])
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
    @blog.update(params_blog)
    
    if @blog.save
      flash[:success]="Blog successfully updated"
      redirect_to @blog
    else
      render 'edit'
    end
  end

  def destroy 
     @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:success]="Blog successfully deleted"
    redirect_to user_profile_path(current_user.id)
  end


  private

  def params_blog
    params.require(:blog).permit(:title, :description, :user_id, :department_id, :blog_image  )
  end

  def department_wish(dep_id)
      @department = Department.find(dep_id)
      return @department.blogs.order(update_at: :desc)
  end

end
