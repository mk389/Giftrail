class DropDagashisAndPostsTables < ActiveRecord::Migration[7.2]
  def up
    drop_table :dagashis, if_exists: true
    drop_table :posts, if_exists: true
  end

  def down
    create_table :dagashis do |t|
      t.string :name
      t.string :image_url
      t.timestamps
    end

    create_table :posts do |t|
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end