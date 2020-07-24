class CreateForumposts < ActiveRecord::Migration[5.2]
  def change
    create_table :forumposts do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :forumposts, [:user_id, :created_at]
  end
end
