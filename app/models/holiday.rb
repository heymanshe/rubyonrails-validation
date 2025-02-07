class Holiday < ApplicationRecord
  validates :name, uniqueness: { scope: :year, message: "should happen once per year" }
end
