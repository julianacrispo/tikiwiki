class AddPostToCollaborations < ActiveRecord::Migration
  def change
    add_column :collaborations, :post_id, :integer
  end
end
