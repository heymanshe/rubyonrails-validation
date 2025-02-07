class Player < ApplicationRecord
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true, greater_than_or_equal_to: 0, even: true }
  validates :age, numericality: { only_integer: true, greater_than: 17, less_than_or_equal_to: 40 }
  validates :rating, numericality: { in: 1.0..10.0 }, allow_nil: true
  validates :salary, numericality: { greater_than: 30000 }
  validates :win_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :losses, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :draws, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :experience, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
