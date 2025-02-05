# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :event_status
  has_many :event_applications, dependent: :destroy
  has_many :warriors, through: :event_applications
  
  validates :name, presence: true, length: { maximum: 100 }
  validates :date, :registration_deadline, presence: true
  validates :location, length: { maximum: 100 }
  validate :registration_deadline_before_event
  validate :at_least_one_category
  
  private
  
  def registration_deadline_before_event
    return unless date && registration_deadline
    
    if registration_deadline >= date
      errors.add(:registration_deadline, 'kayıt bitiş tarihi etkinlik tarihinden önce olmalıdır')
    end
  end
  
  def at_least_one_category
    unless gi || nogi || mma
      errors.add(:base, 'en az bir kategori (Gi, No-Gi veya MMA) seçilmelidir')
    end
  end
end