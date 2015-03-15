class AddPhoneToConversationUsers < ActiveRecord::Migration
  def change
    add_column :conversation_users, :phone, :string
  end
end
