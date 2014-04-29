class Micropost < ActiveRecord::Base
	# validates the presence of the user_id in mircroposts. 
	belongs_to :user 
	# orders microposts 
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true 
end
