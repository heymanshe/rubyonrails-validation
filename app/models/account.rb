class Account < ApplicationRecord
  belongs_to :supplier

  validates :supplier, absence: true
  # validates :subdomain, exclusion: { in: %w[www us ca jp],
  #   message: "%{value} is reserved." }
  validates :subdomain, exclusion: { in: ->(account) { reserved_subdomains },
    # reserved_subdomains is a method that returns a list of restricted words
    message: "%{value} is reserved." }

  def self.reserved_subdomains
    %w[www admin root superuser]
  end
end
