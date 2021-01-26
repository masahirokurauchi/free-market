class Item < ApplicationRecord
	#Associations
	belongs_to :category
	belongs_to :seller, class_name: "User"
    belongs_to :buyer, class_name: "User", optional: :true

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture

	#Validations
	validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
    validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

    #Enum
    enum condition: { good: 0, normal: 1, bad: 2 }
end
