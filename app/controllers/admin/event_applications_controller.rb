# app/controllers/admin/event_applications_controller.rb
class Admin::EventApplicationsController < Admin::BaseController
  before_action :set_application, only: [:update]

  def index
    @applications = EventApplication.includes(:event, :warrior, :event_application_status)
                                 .order(created_at: :desc)
  end

  def update
    if @application.update(application_params)
      redirect_to admin_event_applications_path, notice: 'Başvuru durumu güncellendi.'
    else
      redirect_to admin_event_applications_path, alert: 'Başvuru durumu güncellenemedi.'
    end
  end

  private

  def set_application
    @application = EventApplication.find(params[:id])
  end

  def application_params
    params.require(:event_application).permit(:event_application_status_id)
  end
end