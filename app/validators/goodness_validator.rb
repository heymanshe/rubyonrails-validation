class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if record.name == "Evil"
      record.errors.add :base, "This person is evil"
    end
  end
end
