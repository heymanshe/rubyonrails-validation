class Event < ApplicationRecord
  validates :priority, exclusion: { in: 1..5, message: "Priority %{value} is reserved." }
end
