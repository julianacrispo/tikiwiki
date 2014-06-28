class CreateUsersWikis < ActiveRecord::Migration
  def change
    create_table :users_wikis do |t|
      t.references :user, :wiki
    end
  end
end
