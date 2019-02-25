class CommentsController < ApplicationController
   
    def create
        if session[:user_id] != nil
            @blog = Blog.find(params[:blog_id])
            @comment = @blog.comments.create(comment_params.merge(user_id: current_user.id))
            redirect_to blog_path(@blog)
        else
            redirect_to login_path
        end
    end

    private
    
    def comment_params
        params.require(:comment).permit(:comment)
    end
end
