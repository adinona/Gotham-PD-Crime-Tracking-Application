class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :check_login
  	authorize_resource

	def index
    	@user = User.all.paginate(page: params[:page]).per_page(10)
    end
	def new
    	@user = User.new
    end

  	def create
	    @user = User.new(user_params)
	    if @user.save
	    	flash[:notice] = "Successfully created #{@user.username}."
	    	#session[:user_id] = @user.id
      		redirect_to users_url
	    else
	      render :action => "new"
	    end
	end

  	#before_action :check_login

  	def edit
  	end

  	def update
	    if @user.update_attributes(user_params)
	    	flash[:notice] = "Successfully updated #{@user.username}."
	      	redirect_to @user
	    elsif params[:field].present? # means that the action is used via `best_in_place`
    		render json: { params[:field].to_sym => @user.send(params[:field]) }
	    else      
	      render :action => "edit"
	    end
	end

  def destroy

      if @user.destroy
        flash[:notice] = "Successfully removed #{@user.username}."
        redirect_to users_url
      else
        render action: 'show'
      end
    
  end


  	private

  	def set_user
		@user = User.find(params[:id])
	end

  	def user_params
    	params.require(:user).permit(:username, :role, :password, :password_confirmation, :active)
  	end
end


