class AddFakeIdToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :fake_id, :integer
  end
end
