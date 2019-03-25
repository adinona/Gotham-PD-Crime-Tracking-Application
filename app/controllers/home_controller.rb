class HomeController < ApplicationController


  def index
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end


  def dashboard
    @officer = current_user.officer

    @tofficer = Officer.all.paginate(page: params[:page]).per_page(10)
    @of = Officer.for_unit(current_user.officer.unit)

    @curr_assign = current_user.officer.assignments.current.chronological
    @prev_assign = current_user.officer.assignments.chronological - @curr_assign
    @o_in_unit = current_user.officer.unit.number_of_active_officers
    @uniq_invest = current_user.officer.unit.number_of_unique_open_investigations



    @tunits = Unit.all.alphabetical.paginate(page: params[:page]).per_page(10)
    @total_units = Unit.all.count
    @total_aunits = Unit.active.count
    @total_iaunits = Unit.inactive.count


    @total_invest = Investigation.count
    @solved_i = Investigation.was_solved.count
    @solved_wb = Investigation.was_solved.with_batman.count
    @open_i = Investigation.is_open.count
    @closed_i = Investigation.unsolved.is_closed.count
    @total_solved_by_unit = current_user.officer.unit.officers.map{|o| o.investigations.was_solved}.flatten.uniq.count

    @total_o = Officer.all.count
    @total_ao = Officer.active.count
    @total_iao = Officer.inactive.count



  end
end
