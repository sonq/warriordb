# app/models/event_application_status.rb
class EventApplicationStatus < ApplicationRecord
  has_many :event_applications
  
  validates :name, presence: true, uniqueness: true
  
  def self.default
    find_by(name: 'Onay Bekliyor')
  end
end