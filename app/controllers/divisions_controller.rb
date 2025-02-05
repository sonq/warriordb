# app/controllers/divisions_controller.rb
class DivisionsController < ApplicationController
  before_action :authenticate
  before_action :require_admin
  before_action :set_event

  def index
    @divisions = @event.divisions.includes(:gender, :division_status)
  end

  # app/controllers/divisions_controller.rb
  def generate
    puts "Enqueuing job for event: #{@event.id}"  # Debug line
    DivisionGeneratorJob.perform_now(@event.id)
    redirect_to event_divisions_path(@event), notice: "Kategoriler olu\u015Fturuluyor..."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Bu sayfaya erişim yetkiniz yok."
    end
  end
end
