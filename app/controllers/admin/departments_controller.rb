class Admin::DepartmentsController < ApplicationController
	layout "layouts/adminapplication"

	def index
        if session[:user_id] !=nil
		  @department= Department.all
        else
            redirect_to login_path
        end
	end

    def new
        if session[:user_id] !=nil
            @department =Department.new
        else
            redirect_to login_path
        end        
    end

    def create
        @department = Department.new(department_params)
        if Department.exists?(department_name: params[:department][:department_name])
             flash[:warning]="#{@department.department_name} Allrady Exist....."
             render :new   
        else
            if @department.save   
                flash[:success]="#{@department.department_name} created....."
                redirect_to admin_departments_path
            else
                render :new
            end
        end
    end

    def edit
        if session[:user_id] !=nil
            @department= Department.find(params[:id])
        else
            redirect_to login_path
        end
    end

    def update 
        @department=Department.find(params[:id])

        if @department.update(department_params)
            redirect_to admin_departments_path
        else
            render 'edit'
        end
    end
    
    def destroy 
    	@department = Department.find(params[:id])
    	@department.destroy
    	flash[:success]="Blog successfully deleted"
    	redirect_to admin_departments_path
	end

    private

	def department_params
        params.require(:department).permit(:department_name)
    end
end