class CreateCommentforumlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :commentforumlikes do |t|
      t.references :commentforum, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
