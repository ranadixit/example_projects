class Admin::UsersController < ApplicationController
	layout "layouts/adminapplication"

	def index
		if session[:user_id] !=nil
			@users= User.all
		else
			redirect_to login_path
		end

	end

    def new
        if session[:user_id] !=nil
			@users= User.new
		else
			redirect_to login_path
		end       
    end

    def create
        @user = User.new(user_params)

        if @user.save   
            flash[:success]="#{@user.user_name} created....."
            redirect_to admin_user_path(@user)
        else
            render :new
        end
    end
    
    def show
    	if session[:user_id] !=nil
    		@user = User.find(params[:id])
    	else
			redirect_to login_path
		end  
    end
    
    def edit
        if session[:user_id] !=nil
            @user= User.find(params[:id])
        else
            redirect_to login_path
        end
    end

    def update 
        @user=User.find(params[:id])

        if @user.update(user_params)
            redirect_to admin_user_path(@user)
        else
            render :edit
        end
    end
    
    def destroy 
    	@user = User.find(params[:id])

    	@user.destroy
    	flash[:success]="Blog successfully deleted"
    	redirect_to admin_users_path
	end

    private

	 def user_params
        params.require(:user).permit(:user_name,:email,:department_id,:password,:gender,:profile_image)
    end
end