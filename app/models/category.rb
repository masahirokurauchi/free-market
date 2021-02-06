class Category < ApplicationRecord
	#Associations
	has_many :items
	
	has_ancestry

	#Validations
	validates :name, presence: true
end
