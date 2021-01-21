class Address < ApplicationRecord
	#Association
	belongs_to :user, optional: true

	#Validation
	validates :city, :house_number, :postal_code, presence: true
end
