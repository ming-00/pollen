class CreateForumpostlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :forumpostlikes do |t|
      t.references :forumpost, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
