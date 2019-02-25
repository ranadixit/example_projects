class UsersController < ApplicationController
    
    def new
        @user =User.new
        
    end

    def create
        @user = User.new(params_user)

        if @user.save   
            session[:user_id] = @user.id
            flash[:success]="#{@user.user_name} Welcome....."
            redirect_to user_profile_path(session[:user_id])
        else
            render 'new'
        end
    end

    def edit
        if session[:user_id] !=nil
            @user= User.find(current_user.id)
        else
            redirect_to login_path
        end
    end

    def update 
        @user=User.find(current_user.id)

        if @user.update(params_user)
            redirect_to user_profile_path(@user)
        else
            render 'edit'
        end
    end

    def newlogin
         @user=User.new 
    end

    def login
         @user = User.find_by(email: params[:user][:email])
        if @user
            puts @user.email
            puts @user.password
            if @user.password == params[:user][:password]
                session[:user_id] = @user.id
                flash[:success]="#{@user.user_name} was successfully login"
                redirect_to user_profile_path(session[:user_id]) 

            else
                flash[:danger]="Plase enter correct password"
                render :newlogin
                
                            
            end
        else
            flash[:danger]="Plase enter correct value"
            render :newlogin
            
            
        end
    end

    def logout
        session[:user_id] = nil
        flash[:warning]="Logged out!"
        render :newlogin
        
         
    end

    def profile
        if session[:user_id]!=nil
            @user=User.find(current_user.id)
            @blogs = Blog.select(:id,:title,:description).where("user_id=?",current_user.id)
        else
            redirect_to login_path
        end
    end

    private

    def params_user
        params.require(:user).permit(:user_name,:email,:department_id,:password,:gender,:profile_image)
    end
end