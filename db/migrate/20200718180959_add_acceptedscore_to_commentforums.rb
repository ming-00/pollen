class AddAcceptedscoreToCommentforums < ActiveRecord::Migration[5.2]
  def change
    add_column :commentforums, :acceptedscore, :integer
  end
end
