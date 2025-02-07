# 1. Validation Overview

- **Purpose**: Ensure that only valid data is saved in the database.

    - ```ruby
      validates :name, presence: true
      ```
    - This checks if the `name` attribute is provided before saving a `Person` object.



- **valid? Method**:
    - Runs validations and returns `true` if no errors are found.

    - ```ruby
      Person.create(name: "John Doe").valid?  # true
      Person.create(name: nil).valid?  # false
      ```

## 1.1 Why Use Validations?

- `Ensures Data Integrity`:  Ensures only valid data gets saved to the database.

- `Database-Agnostic`: Model-level validations can’t be bypassed like client-side validations can.

- `Built-In Helpers`: Rails provides helper methods for common validation checks (e.g., `presence`, `uniqueness`).

- `Comparison`:
    - **Database Constraints**: Useful for ensuring things like uniqueness but can be hard to test and maintain.
    - **Client-Side Validations**: Can be unreliable if JavaScript is disabled.
    - **Controller-Level Validations**: Can make the controller unwieldy, so it's better to keep validations in the model.

## 1.2 When Do Validations Happen?

- `Object Creation`: When a new object is created using `new`, it doesn’t belong to the database yet.

- `Save Operation`:
    - **Before Save**: Validations happen before the object is saved to the database. If any validation fails, the save will not occur.
    - **Creating**: `create` triggers validations and attempts to insert a new record into the database.
    - **Updating**: `update` triggers validations for existing records.

- `Methods That Trigger Validation`:
    - `create`, `create!`, `save`, `save!`, `update`, `update!` trigger validations before saving.
    - The “bang” methods (`create!`, `save!`, `update!`) raise an exception if validation fails, while non-bang versions return `false`.

## 1.3 Methods That Skip Validations

- These methods bypass validations and save invalid data to the database. Use them with caution:
    - `decrement!`, `increment!`, `insert`, `update_all`, `update_attribute`, etc.

    - ```ruby
      save(validate: false)  # skips validations
      ```
    
    - ```ruby 
      # skipping validation with update_attribute
      person = Person.create(name: "Valid Name")
      person.update_attribute(:name, nil)  # Skips validation and updates to invalid state
      ```

## 1.4 Valid and Invalid Objects

- **valid?**: Returns `true` if no errors were found during validation, otherwise `false``.

- **invalid?**: The opposite of `valid?`; returns `true` if errors were found.

- **errors**: Provides access to validation errors for a model object.
    - ```ruby
      p = Person.create
      p.errors.full_messages  # ["Name can't be blank"]
      ```

## 1.5 Working with Validation Errors

- **Accessing Errors**:

    - You can access errors for a specific attribute using `errors[:attribute]`.
    - ```ruby
      Person.new.errors[:name]  # returns an array of error messages for `name`
      ```

## 1.6 Summary of Key Methods:

- **valid?**: Triggers validations and returns `true` if no errors are found, `false` otherwise.

- **invalid?**: Returns `true` if errors are found.

- **errors**: Access errors related to the object.

- **errors[:attribute]**: Check errors for a specific attribute.

- **Create & Save Methods**:
    - `create` and `save` trigger validations before saving.
    - `create!` and `save!` raise exceptions when validations fail.
    - Methods like `insert`, `update_all` skip validations and should be used carefully.


# 2. Validation Helpers

## 2.1 acceptance

- Ensures that a checkbox (e.g., terms of service agreement) is checked.

- ```ruby
  validates :terms_of_service, acceptance: true
  ```

## 2.2 confirmation

- Validates that two fields have the same value (e.g., password confirmation).

- ```ruby
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  ```

## 2.3 comparison

- Validates that one attribute is compared to another (e.g., start_date must be earlier than end_date).

- ```ruby
  validates :end_date, comparison: { greater_than: :start_date }
  ```
  
## 2.4 format 

- Ensures that an attribute matches a specific regular expression pattern (e.g., email format).

- ```ruby
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  ```
  
## 2.5 inclusion

- Ensures that the attribute value is included in a given set of values (e.g., predefined list of options).

- ```ruby
  validates :size, inclusion: { in: %w(small medium large), message: "%{value} is not a valid size" }
  ```

## 2.6 exclusion 

- Ensures that the attribute value is not included in a given set (e.g., reserved usernames).

- ```ruby
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
  ```

## 2.7 length 

- Validates the length of an attribute (e.g., string length constraints).

- ```ruby
  validates :name, length: { minimum: 2 }
  validates :password, length: { in: 6..20 }
  ```

## 2.8 numericality 

- Ensures that an attribute contains only numeric values.

- ```ruby
  validates :points, numericality: true
  ```

## 2.9 presence 

- Ensures that an attribute is not empty or nil.

- ```ruby
  validates :name, :login, :email, presence: true
  ```
  
## 2.10 absence 

- Ensures that an attribute is empty or nil.

- ```ruby
  validates :name, :login, :email, absence: true
  ```
  
## 2.11 uniqueness 

- Ensures that an attribute's value is unique in the database.

- ```ruby
  validates :email, uniqueness: true
  ```

## 2.12 validates_associated 

- Used when model has associations that always need to be validated.

- ```ruby
  validates_associated :books
  ```

# 3. Common Validation Options


## :allow_nil

- Skips validation if the attribute is `nil`.

```ruby
  class Coffee < ApplicationRecord
    validates :size, inclusion: { in: %w(small medium large),
      message: "%{value} is not a valid size" }, allow_nil: true
  end
  ```

```bash
Coffee.create(size: nil).valid?  # => true
Coffee.create(size: "mega").valid?  # => false
```

## :allow_blank

- Similar to `:allow_nil`, but skips validation for blank values (`nil` or empty string `""`).

 ```ruby
  class Topic < ApplicationRecord
    validates :title, length: { is: 5 }, allow_blank: true
  end
  ```

```bash
Topic.create(title: "").valid?  # => true
Topic.create(title: nil).valid?  # => true
```

## :message

- Allows specifying a custom error message when validation fails.

- Supports placeholders like `%{value}`, `%{attribute}`, and `%{model}`.

```ruby
class Person < ApplicationRecord
  validates :name, presence: { message: "must be given please" }
  validates :age, numericality: { message: "%{value} seems wrong" }
end
```

- Can also accept a `Proc`:
```ruby
class Person < ApplicationRecord
  validates :username,
    uniqueness: {
      message: ->(object, data) do
        "Hey #{object.name}, #{data[:value]} is already taken."
      end
    }
end
```

## :on

- Specifies when the validation should be executed.

- Default: Runs on both `create` and `update`.

- Options:

`on: :create` → Runs validation only when creating a new record.

`on: :update` → Runs validation only when updating a record.

- Custom contexts can be defined and explicitly triggered.

```ruby
class Person < ApplicationRecord
  validates :email, uniqueness: true, on: :create
  validates :age, numericality: true, on: :update
  validates :name, presence: true
end
```

```bash
person = Person.new(age: 'thirty-three')
person.valid?(:account_setup)  # => false
person.errors.messages  # => {:email=>["has already been taken"], :age=>["is not a number"]}
```

- Custom contexts:
```ruby
class Book
  include ActiveModel::Validations
  validates :title, presence: true, on: [:update, :ensure_title]
end
```

 ```bash
  book = Book.new(title: nil)
  book.valid?(:ensure_title)  # => false
  book.errors.messages  # => {:title=>["can't be blank"]}
  ```

- When using a custom context, it also includes validations without a context:
 ```ruby
  class Person < ApplicationRecord
    validates :email, uniqueness: true, on: :account_setup
    validates :age, numericality: true, on: :account_setup
    validates :name, presence: true
  end
```
 ```bash
  person = Person.new
  person.valid?(:account_setup)  # => false
  person.errors.messages  # => {:email=>["has already been taken"], :age=>["is not a number"], :name=>["can't be blank"]}
  ```

# 4. Strict Validations

## :strict

- Raises `ActiveModel::StrictValidationFailed` when the object is invalid.

```ruby
class Person < ApplicationRecord
  validates :name, presence: { strict: true }
end
```

```bash
Person.new.valid?
# ActiveModel::StrictValidationFailed: Name can't be blank
```

- Custom exception with `:strict`:

```ruby
class Person < ApplicationRecord
  validates :token, presence: true, uniqueness: true, strict: TokenGenerationException
end
```

```bash
Person.new.valid?
# TokenGenerationException: Token can't be blank
```

# 5. Conditional Validation


## 5.1 Using a Symbol with :if and :unless

- Associates a validation with a method that determines when it should run.

```ruby
class Order < ApplicationRecord
  validates :card_number, presence: true, if: :paid_with_card?

  def paid_with_card?
    payment_type == "card"
  end
end
```

## 5.2 Using a Proc with :if and :unless

- Allows inline conditions instead of defining separate methods.

```ruby
class Account < ApplicationRecord
  validates :password, confirmation: true,
    unless: Proc.new { |a| a.password.blank? }
end
```

- Using a lambda for inline conditions:

```ruby
validates :password, confirmation: true, unless: -> { password.blank? }
```

## 5.3 Grouping Conditional Validations

- `with_options` helps group multiple validations under a single condition.

```ruby
class User < ApplicationRecord
  with_options if: :is_admin? do |admin|
    admin.validates :password, length: { minimum: 10 }
    admin.validates :email, presence: true
  end
end
```

- All validations inside the block are applied only if `is_admin?` is true.

## 5.4 Combining Validation Conditions

- Multiple conditions can be used together with an array.

```ruby
class Computer < ApplicationRecord
  validates :mouse, presence: true,
                    if: [Proc.new { |c| c.market.retail? }, :desktop?],
                    unless: Proc.new { |c| c.trackpad.present? }
end
```

- The validation only runs when all `:if` conditions are met and none of the `:unless` conditions are true.

# 6. Custom Validations

## 6.1 Custom Validators

- Create a class inheriting from `ActiveModel::Validator`.

- Implement the validate method.

```ruby
class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.name.start_with? "X"
      record.errors.add :name, "Provide a name starting with X, please!"
    end
  end
end


class Person < ApplicationRecord
  validates_with MyValidator
end
```

## 6.2 Custom Methods

- Define methods that validate model attributes and add errors.

- Register methods using validate.

```ruby
class Invoice < ApplicationRecord
  validate :expiration_date_cannot_be_in_the_past,
           :discount_cannot_be_greater_than_total_value

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  def discount_cannot_be_greater_than_total_value
    if discount > total_value
      errors.add(:discount, "can't be greater than total value")
    end
  end
end
```

## 6.3 Listing Validators

- Use validators to list all validations.

```ruby
  Person.validators
  Person.validators_on(:name)
```

# 7. Validation Errors

## 7.1 errors

- Provides access to all validation errors.

```ruby
class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
end
```
```bash
person = Person.new
person.valid?
person.errors.full_messages #=> ["Name can't be blank", "Name is too short (minimum is 3 characters)"]
```
## 7.2 errors[]

- Retrieves errors for a specific attribute.

```bash
person.errors[:name] #=> ["can't be blank", "is too short (minimum is 3 characters)"]
```

## 7.3 errors.where

- Filters errors based on attributes and types.

```bash
person.errors.where(:name, :too_short) #=> [...] 
```

## 7.4 errors.add

- Manually adds errors.

```ruby
errors.add :name, :too_plain, message: "is not cool enough"
```

# 7.5 errors[:base]

- Adds errors not tied to a specific attribute.

```ruby
errors.add :base, :invalid, message: "This person is invalid because ..."
```

## 7.6 errors.size

- Returns the total number of validation errors.

## 7.7 errors.clear

- Clears all errors but does not make an object valid.

```bash
person.errors.clear
```
