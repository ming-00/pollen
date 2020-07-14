class AddResolvedToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :resolved, :boolean
  end
end
