class User < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { minimum: 6, maximum: 10 }
  validates :is_admin, inclusion: { in: [ true, false ] }
  # OR
  # validates :is_admin, exclusion: { in: [nil] }
  validates :login, absence: true
  validates :email, uniqueness: true

  validates :username,
    uniqueness: {
      message: ->(object, data) do
        "Hey #{object.name}, #{data[:value]} is already taken."
      end
    }
end
