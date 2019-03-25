class CriminalsController < ApplicationController
	before_action :set_criminal, only: [:show, :edit, :update, :destroy]
  	before_action :check_login

  	authorize_resource

	def index
		@all_criminals = Criminal.alphabetical.paginate(page: params[:page]).per_page(10)
		@convicted_criminals = Criminal.prior_record.alphabetical.paginate(page: params[:page]).per_page(10)
		@enhanced_criminals = Criminal.enhanced.alphabetical.paginate(page: params[:page]).per_page(10)

	end

	def show
		@current_investigations = @criminal.investigations.is_open.chronological
    	@past_investigations = @criminal.investigations.is_closed.chronological
	end

	def new
		@criminal = Criminal.new
		

	end

	def edit
	end


  def search
    @query = params[:query]
    @criminals = Criminal.search(@query)
    @total_hits = @criminals.size
    
  end

	def create
		@criminal = Criminal.new(officer_params)
		if @criminal.save
			flash[:notice] = "Successfully created #{@criminal.proper_name}."
			redirect_to officer_path(@criminal) 
		else
			render action: 'new'
		end      
	end

	def update
		respond_to do |format|
			if @criminal.update_attributes(officer_params)
				format.html { redirect_to @criminal, notice: "Updated all information" }

			else
				format.html { render :action => "edit" }

			end
		end
	end

	def destroy

	    if @criminal.destroy
	      flash[:notice] = "Successfully removed #{@criminal.name}."
	      redirect_to criminals_url
	    else
	      render action: 'show'
	    end
		
	end



	private
	# Use callbacks to share common setup or constraints between actions.
	def set_criminal
		@criminal = Criminal.find(params[:id])
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def officer_params
		params.require(:criminal).permit(:first_name, :last_name, :aka, :convicted_felon, :enhanced_powers, :notes)
	end

end
