# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @events = Event.order(date: :asc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Etkinlik başarıyla oluşturuldu.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Etkinlik başarıyla güncellendi.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Etkinlik başarıyla silindi.', status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location, :registration_deadline, 
                                :event_status_id, :description, :gi, :nogi, :mma)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to events_path, alert: 'Bu işlem için yetkiniz yok.'
    end
  end
end