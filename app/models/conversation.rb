class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :conversation_users
  has_many :users, through: :conversation_users
  validates :user_id, presence: true
  before_save :set_title

	def set_title
		self.title = "No Subject" if self.title.nil? || self.title.blank?
	end
end
