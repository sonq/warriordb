# app/controllers/event_applications_controller.rb
class EventApplicationsController < ApplicationController
  before_action :authenticate
  before_action :require_warrior_profile
  before_action :set_available_events, only: [:new, :create]

  def index
    @applications = current_user.warrior.event_applications.includes(:event).order(created_at: :desc)
  end

  def show
    @application = current_user.warrior.event_applications.includes(:event).find(params[:id])
  end

  def new
    @application = EventApplication.new(
      warrior: current_user.warrior,
      weight: current_user.warrior.weight
    )
  end

  # app/controllers/event_applications_controller.rb
  def create
    @application = EventApplication.new(application_params)
    @application.warrior = current_user.warrior
    
    if @application.save
      redirect_to my_applications_path, notice: 'Başvurunuz başarıyla alındı.'
    else
      set_available_events
      render :new, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:event_application).permit(:event_id, :weight, :gi, :nogi, :mma, :notes)
  end

  def require_warrior_profile
    unless current_user.warrior
      redirect_to new_warrior_path, alert: 'Başvuru yapabilmek için önce sporcu profili oluşturmalısınız.'
    end
  end

  def set_available_events
    @available_events = Event.joins(:event_status)
                           .where(event_statuses: { name: 'Yayında' })
                           .where('registration_deadline >= ?', Date.today)
                           .order(:date)
  end
end