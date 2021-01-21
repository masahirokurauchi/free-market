class Address < ApplicationRecord
	#Association
	belongs_to :user, optional: true
end
