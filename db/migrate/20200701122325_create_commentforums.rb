class CreateCommentforums < ActiveRecord::Migration[5.2]
  def change
    create_table :commentforums do |t|
      t.text :reply
      t.references :forumpost, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
