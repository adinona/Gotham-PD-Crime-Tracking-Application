class CrimeInvestigationsController < ApplicationController
  	before_action :check_login
  	authorize_resource

  def new
    @crimeInvestigation = CrimeInvestigation.new
    @investigation = Investigation.find(params[:investigation_id])
    @investigation_crimes = @investigation.crimes.active



  end

  def show

  end
  
  def create
    @crimeInvestigation = CrimeInvestigation.new(crimeInvestigation_params)
    if @crimeInvestigation.save
      flash[:notice] = "Successfully added crime to investigation."
      redirect_to investigation_path(@crimeInvestigation.investigation)

    else
      @investigation     = Investigation.find(params[:crime_investigation][:investigation_id])
      render action: 'new', locals: { investigation: @investigation }

    end
  end

	def destroy
      @crime_investigation = CrimeInvestigation.find(params[:id])
      @crime_investigation.destroy
      flash[:notice] = "Successfully removed this investigation."
      redirect_to investigation_path
    end


  private


  def crimeInvestigation_params
    params.require(:crime_investigation).permit(:investigation_id, :crime_id)
  end
end
