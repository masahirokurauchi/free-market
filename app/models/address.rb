class Address < ApplicationRecord
	#Association
	belongs_to :user, optional: true

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture

	#Validation
	validates :city, :house_number, :postal_code, presence: true
end
