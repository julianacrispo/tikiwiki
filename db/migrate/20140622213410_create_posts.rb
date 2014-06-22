rakclass CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.references :wiki, index: true

      t.timestamps
    end
  end
end