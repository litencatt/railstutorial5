class CreateUserOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :user_oauths do |t|
      t.integer :user_id, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :meta

      t.timestamps
    end
  end
end
