class RemoveSendFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :confirmation_send_at
  end
end
