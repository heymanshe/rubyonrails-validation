class Book < ApplicationRecord
  belongs_to :library
  validates :title, presence: true
end
