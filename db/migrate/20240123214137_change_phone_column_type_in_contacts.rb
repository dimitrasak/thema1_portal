class ChangePhoneColumnTypeInContacts < ActiveRecord::Migration[7.1]
  def change
    change_column :contacts, :phone, :bigint
  end
end
