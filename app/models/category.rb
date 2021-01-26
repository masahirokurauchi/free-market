class Category < ApplicationRecord
	#Validations
	validates :name, presence: true
end
