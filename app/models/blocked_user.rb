class BlockedUser < ActiveRecord::Base
	  belongs_to :user
	  validates :user_id, presence: true
	  validates :blocked_id, presence: true

	def already_blocked?(user_id, blocked_id)
		blocked_user = BlockedUser.where(user_id: user_id, blocked_id: blocked_id)[0]
		return true if blocked_user
	    return false if !blocked_user
	end

end