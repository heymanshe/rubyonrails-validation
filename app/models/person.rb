class Person < ApplicationRecord
  validates :name, presence: { strict: true }

  validates :email, confirmation: true, presence: true, uniqueness: true, on: :create

  validates :terms_of_service, acceptance: { message: "must be abided" }

  validates_each :name, :surname do |record, attr, value|
    record.errors.add(attr, "must start with an uppercase letter") if value.present? && value[0] =~ /[a-z]/
  end

  validates_with GoodnessValidator

  validates :age, numericality: { message: "%{value} seems wrong" }, on: :update
end
