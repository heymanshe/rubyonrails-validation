class Voter < ApplicationRecord
  validate :must_be_old_enough_to_vote

  def must_be_old_enough_to_vote
    if age.present? && age < 18
      errors.add(:base, "You must be at least 18 years old to vote")
    end
  end
end
