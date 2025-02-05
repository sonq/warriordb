# app/controllers/academies_controller.rb
class AcademiesController < ApplicationController
  def index
    @academies = Academy.order(:name)
  end

  def show
    @academy = Academy.find(params[:id])
    @warriors = @academy.warriors.order(:first_name, :last_name)
  end

  def new
    @academy = Academy.new
  end

  def create
    @academy = Academy.new(academy_params)

    if @academy.save
      redirect_to academies_path, notice: 'Akademi başarıyla oluşturuldu.' # rubocop:disable Style/StringLiterals
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def academy_params
    params.require(:academy).permit(:name, :phone, :address, :email)
  end
end
