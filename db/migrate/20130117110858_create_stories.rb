class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :author
      t.string :subtitle
      t.text :body
      t.date :published_on

      t.timestamps
    end
  end
end
