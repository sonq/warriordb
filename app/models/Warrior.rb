# app/models/warrior.rb
class Warrior < ApplicationRecord
  belongs_to :user
  belongs_to :academy
  has_many :event_applications
  has_many :events, through: :event_applications
  

  validates :first_name, :last_name, :date_of_birth, :weight, :belt_rank, presence: true
  validates :first_name, :last_name, length: { maximum: 50 }
  validates :phone, length: { maximum: 20 }
  validates :belt_rank, length: { maximum: 20 }
  validates :weight, numericality: { greater_than: 0 }
  validates :experience_years, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_nil: true

  # Ensure at least one type of practice is selected
  validate :at_least_one_practice_type

  # Belt validation
  validates :belt_rank, inclusion: {
    in: [ 'Beyaz', 'Mavi', 'Mor', 'Kahverengi', 'Siyah' ], # rubocop:disable Style/StringLiterals
    message: "%{value} geçerli bir kuşak değil"
  }

  # Age validations
  validate :valid_birth_date

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  private

  def at_least_one_practice_type
    unless gi_practitioner || nogi_practitioner
      errors.add(:base, 'En az bir kategori (Gi veya No-Gi) seçilmelidir') # rubocop:disable Style/StringLiterals
    end
  end

  def valid_birth_date
    if date_of_birth.present? && date_of_birth > Time.zone.today
      errors.add(:date_of_birth, 'gelecekte bir tarih olamaz') # rubocop:disable Style/StringLiterals
    end

    if date_of_birth.present? && age < 4
      errors.add(:date_of_birth, 'sporcu 4 yaşından büyük olmalıdır') # rubocop:disable Style/StringLiterals
    end
  end
end
