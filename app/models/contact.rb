class Contact < ApplicationRecord
    belongs_to :user

    validates :name, :email, :phone, presence: true
end
