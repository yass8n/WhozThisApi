class ConversationUser < ActiveRecord::Base
  validates :phone, presence: true
  validates :conversation_id, presence: true
  belongs_to :conversation
  belongs_to :user
  scope :active, -> { where(deleted: false) } #this scope is used in the get stream function for users
  before_save :strip_phone_number

  	def strip_phone_number
		if (self.phone != nil) then
	        self.phone.gsub!(")", "");
	        self.phone.gsub!("(", "");
	        self.phone.gsub!(" ", "");
	        self.phone.gsub!("-", "");
	        self.phone.gsub!("/", "");
	        self.phone.sub!(/^1/, ''); #if it starts with a 1, remove it
	    end
	end
end
