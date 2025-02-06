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
