class Coffee < ApplicationRecord
  class TokenGenerationException < StandardError; end


  validates :size, inclusion: { in: %w[small medium large],
    message: "%{value} is not a valid size" }, allow_nil: true

  validates :token, presence: true, uniqueness: true, strict: TokenGenerationException
end
