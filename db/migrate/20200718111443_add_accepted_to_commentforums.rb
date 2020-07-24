class AddAcceptedToCommentforums < ActiveRecord::Migration[5.2]
  def change
    add_column :commentforums, :accepted, :boolean
  end
end
