# app/models/academy.rb
class Academy < ApplicationRecord
  has_many :warriors, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 100 }
  validates :phone, length: { maximum: 20 }
  validates :email, length: { maximum: 100 },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            allow_blank: true

  # If you want to prevent academies with same name
  validates :name, uniqueness: true

  def warrior_count
    warriors.count
  end

  def display_name
    "#{name} (#{warrior_count} sporcu)"
  end
end
