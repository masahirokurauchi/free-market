class Category < ApplicationRecord
	#Associations
	has_many :items
	
	#Validations
	validates :name, presence: true
end
