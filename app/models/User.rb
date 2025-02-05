# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_one :warrior, dependent: :destroy

  enum :role, [ :fighter, :organizer, :admin ], default: :fighter

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  def has_warrior_profile?
    warrior.present?
  end
end
