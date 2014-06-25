class AddPrivateToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :boolean, default: false
    add_index :wikis, :private
  end
end
