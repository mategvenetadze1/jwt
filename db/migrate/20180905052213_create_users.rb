class CreateUsers < ActiveRecord::Migration[5.2]
  def changes
    create_table :users do |t|
      t.string :email,            null: false
      t.string :password_digest,  null: false
      t.string :confirmation_token
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
