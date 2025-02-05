# app/controllers/warriors_controller.rb
class WarriorsController < ApplicationController
  before_action :set_warrior, only: [ :show, :edit, :update ]
  before_action :ensure_one_profile, only: [ :new, :create ]

  def show
  end

  def new
    @warrior = current_user.build_warrior
  end

  def create
    @warrior = current_user.build_warrior(warrior_params)

    if @warrior.save
      redirect_to warrior_path, notice: 'Sporcu profili başarıyla oluşturuldu.' # rubocop:disable Style/StringLiterals
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @warrior.update(warrior_params)
      redirect_to warrior_path, notice: 'Sporcu profili başarıyla güncellendi.' # rubocop:disable Style/StringLiterals
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_warrior
    @warrior = current_user.warrior
    redirect_to new_warrior_path, alert: 'Önce profil oluşturmalısınız.' if @warrior.nil? # rubocop:disable Style/StringLiterals
  end

  def ensure_one_profile
    redirect_to warrior_path, alert: 'Zaten bir profiliniz var.' if current_user.warrior.present? # rubocop:disable Style/StringLiterals
  end

  def warrior_params
    params.require(:warrior).permit(
      :first_name, :last_name, :date_of_birth,
      :weight, :belt_rank, :academy_id,
      :experience_years, :phone, :gender_id,
      :gi_practitioner, :nogi_practitioner, :mma
    )
  end
end
