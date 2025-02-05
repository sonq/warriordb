# app/models/event_application.rb
class EventApplication < ApplicationRecord
  belongs_to :event
  belongs_to :warrior
  belongs_to :event_application_status

  before_validation :set_default_status, on: :create
  
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validate :at_least_one_category
  validate :categories_match_event
  validates :warrior_id, uniqueness: { scope: :event_id, message: 'zaten bir başvurun bulunmakta.' }
  
  private
  
  def at_least_one_category
    unless gi || nogi || mma
      errors.add(:base, 'en az bir kategori (Gi, No-Gi veya MMA) seçilmelidir')
    end
  end
  
  def categories_match_event
    errors.add(:gi, "bu etkinlikte Gi kategorisi bulunmuyor") if gi && !event.gi
    errors.add(:nogi, "bu etkinlikte No-Gi kategorisi bulunmuyor") if nogi && !event.nogi
    errors.add(:mma, "bu etkinlikte MMA kategorisi bulunmuyor") if mma && !event.mma
  end

  def set_default_status
    self.event_application_status ||= EventApplicationStatus.default
  end
end


 