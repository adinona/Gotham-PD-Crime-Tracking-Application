class InvestigationNotesController < ApplicationController
	before_action :set_investigationNotes, only: [:show, :edit, :update, :destroy]
  	before_action :check_login
  	authorize_resource


	def index

	end

	def show
		
	end

	def new
		# byebug
		@investigationNote = InvestigationNote.new

		unless params[:investigation_id].nil?
	      @investigation    = Investigation.find(params[:investigation_id])
	    end
	    unless params[:officer_id].nil?
	    	@officer = Officer.find(params[:officer_id])
	    end

	end

	def edit
	end

	def create
		@investigationNote = InvestigationNote.new(investigationNote_params)
		if @investigationNote.save
			flash[:notice] = "Successfully created the note."
			redirect_to investigation_path(@investigationNote.investigation) 
		else
			@investigation = Investigation.find(params[:investigation_note][:investigation_id])
			@officer = Officer.find(params[:investigation_note][:officer_id])
			render action: 'new', locals: {investigation: @investigation, officer_id: @officer}
		end      
	end

	def update
		respond_to do |format|
			if @investigationNote.update_attributes(investigationNote_params)
				format.html { redirect_to @investigationNote, notice: "Updated all information" }

			else
				format.html { render :action => "edit" }

			end
		end
	end


  def destroy

      if @investigationNote.destroy
        flash[:notice] = "Successfully removed #{@investigationNote.content}."
        redirect_to investigation_url(@investigationNote.investigation)
      else
        render action: 'show'
      end
    
  end





	private
	# Use callbacks to share common setup or constraints between actions.
	def set_investigationNotes
		@investigationNote = InvestigationNote.find(params[:id])
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def investigationNote_params
		params.require(:investigation_note).permit(:investigation_id, :officer_id, :content)
	end
end
