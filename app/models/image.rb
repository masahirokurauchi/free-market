class Image < ApplicationRecord
	#Associations
	belongs_to :item
	
	mount_uploader :src, ImageUploader
end
