class Gender < ApplicationRecord
  has_many :warriors

  validates :name, presence: true, uniqueness: true
end
