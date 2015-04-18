class AddColorToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :color, :string
  end
end
