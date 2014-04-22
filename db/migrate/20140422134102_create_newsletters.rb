class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.datetime :released_at
      t.string :title
      t.text :description
      t.attachment :asset

      t.timestamps
    end
  end
end
