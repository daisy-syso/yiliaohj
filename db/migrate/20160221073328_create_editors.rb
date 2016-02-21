class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :username
      t.string :email
      t.string :telephone
      t.string :password_hash

      t.timestamps null: false
    end
  end
end
