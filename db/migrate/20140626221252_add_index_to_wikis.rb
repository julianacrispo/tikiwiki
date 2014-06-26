class AddIndexToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :collaboration_id, :integer
    add_index :wikis, :collaboration_id
  end
end
