# app/models/division_status.rb
class DivisionStatus < ApplicationRecord
  has_many :divisions
  validates :name, presence: true, uniqueness: true
end
