class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
