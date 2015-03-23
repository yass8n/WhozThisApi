class AddDeletedToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :deleted, :boolean
  end
end
