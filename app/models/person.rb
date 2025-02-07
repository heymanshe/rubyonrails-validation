class Person < ApplicationRecord
  validates :name, presence: true
  validates :email, confirmation: true, presence: true
  validates :terms_of_service, acceptance: { message: "must be abided" }
  validates_each :name, :surname do |record, attr, value|
    record.errors.add(attr, "must start with an uppercase letter") if value.present? && value[0] =~ /[a-z]/
  end

  validates_with GoodnessValidator
end
