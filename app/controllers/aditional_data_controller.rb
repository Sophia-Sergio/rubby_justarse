# datos adicionales de inicio
class AditionalDataController < ApplicationController
  include AditionalDataHelper
  before_action :authenticate_user!
  before_action :set_action

  def steps
    redirect_to dashboard_pages_path if current_user.config? && @action != 'edit_profile'
    @sports = Sport.left_outer_joins(:user_sports).distinct
                   .select('sports.*, user_sports.expertice').group('id')
    @user_sport = UserSport.where(user_id: current_user.id)
  end

  # Runs a subprocess and applies handlers for stdout and stderr
  # Params:
  # +command+:: command line string to be executed by the system
  # +outhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # +errhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def choose_sports
    sports = params['sports']
    UserSport.create_or_update(sports, current_user.id) if sports.present?
    return if params['action_sender'] == 'edit_profile' # edit profile
  end

  # Runs a subprocess and applies handlers for stdout and stderr
  # Params:
  # +command+:: command line string to be executed by the system
  # +outhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # +errhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def choose_gender_and_age
    @user = User.find(current_user.id)
    @user.update(gender: params['gender'].to_i, age: params['age'].to_i)
    @action
  end

  # Runs a subprocess and applies handlers for stdout and stderr
  # Params:
  # +command+:: command line string to be executed by the system
  # +outhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  # +errhandler+:: +Proc+ object that takes a pipe object as first and only param (may be nil)
  def choose_disponibility
    add_disponibilities(params['disponibilities']) if params['disponibilities'].present?    
    @disponibilities = current_user.disponibilities
    @sports = current_user.sports
    current_user.config = true 
    current_user.save
    redirect_to dashboard_pages_path if @action != 'edit_profile'
  end

  private

  def set_action
    @action = params['action_sender']
  end
end
