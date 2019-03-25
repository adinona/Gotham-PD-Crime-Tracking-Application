class OfficersController < ApplicationController
  before_action :set_officer, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource


  def index
    @active_officers = Officer.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_officers = Officer.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def show

    @current_assignments = @officer.assignments.current.chronological
    @past_assignments = @officer.assignments.past.chronological

  end

  def search
    @query = params[:query]
    @officers = Officer.search(@query)
    @total_hits = @officers.size
    
  end

  def new
    @officer = Officer.new

  end

  def edit
  end

  def create
    @officer = Officer.new(officer_params)
    @user = User.new(user_params)
    @user.role = "officer"
      if !@user.save
        @officer.valid?
        render action: 'new'
      else
        @officer.user_id = @user.id
        if @officer.save
          flash[:notice] = "Successfully created #{@officer.proper_name}."
          redirect_to officer_path(@officer) 
        else
          render action: 'new'
        end      
      end
    #@user.active = true
  end

  def update
    respond_to do |format|
      if @officer.update_attributes(officer_params)
        format.html { redirect_to @officer, notice: "Updated all information" }
      elsif params[:field].present? # means that the action is used via `best_in_place`
        render json: { params[:field].to_sym => @officer.send(params[:field]) }
      else
        format.html { render :action => "edit" }
        
      end
    end
  end

  def destroy

      if @officer.destroy
        flash[:notice] = "Successfully removed #{@officer.name}."
        redirect_to officers_url
      else
        render action: 'show'
      end
    
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_officer
    @officer = Officer.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def officer_params
    params.require(:officer).permit(:first_name, :last_name, :rank, :ssn, :active, :unit_id,:active, :username, :password, :password_confirmation)
  end

   def user_params      
      params.require(:officer).permit(:active, :username, :password, :password_confirmation)
    end


end
