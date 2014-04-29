class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    #adds index to the user_id and created at tables.
    add_index :microposts, [:user_id, :created_at]
  end
end
