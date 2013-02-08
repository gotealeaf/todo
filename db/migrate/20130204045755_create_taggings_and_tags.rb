class CreateTaggingsAndTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_id, :todo_id
      t.timestamps
    end
  end

  def down
    drop_table :tags
    drop_table :taggings
  end
end
