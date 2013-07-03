class CreateStories < ActiveRecord::Migration

  def change
    create_table :stories do |t|
      t.belongs_to :author

      t.string :title
      t.text   :body

      t.timestamps
    end

    add_index :stories, :author_id
  end

end
