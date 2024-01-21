class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    change_table :users, bulk: true do |t|
      t.string :provider
      t.string :uid
    end
  end
end
