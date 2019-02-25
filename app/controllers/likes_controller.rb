class LikesController < ApplicationController
   
    def create
        if session[:user_id] != nil
            @blog = Blog.find(params[:blog_id])
            @like_check= Like.find_by("user_id=? AND blog_id=?",current_user.id,@blog.id)

          if @like_check == nil

            @like = @blog.likes.create(like_params.merge(user_id: current_user.id))
            redirect_to blog_path(@blog)  
          else   
            flash[:danger]="Already liked this blog....."
            redirect_to blog_path(@blog)
          end
          
        else
            redirect_to login_path
        end
    end

    private
    
    def like_params
        params.require(:like).permit(:blog_like)
    end
end
