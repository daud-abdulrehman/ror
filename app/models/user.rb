class User < ApplicationRecord
    validates :name, presence: true
    validate :unique_name, on: :create
    has_many :comments


    private

    def unique_name
      existing_user = User.find_by(name: name)

      # If an existing user is found and it's not the current user being updated,
      # add an error to the name attribute.
      if existing_user && (new_record? || existing_user.id != id)
         errors.add(:name, "has already been taken")
      end
      if User.count >= 6
        errors.add(:base, "Only a maximum of 6 users are allowed.")
      end
    end

    
    after_create do |user|
        puts"You have succesfully created a user"
    end
    after_save do |user|
        puts"You have successfully saved a user"
    end
end


