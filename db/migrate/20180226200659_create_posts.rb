class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts, id: :uuid do |t|

      t.uuid   :user_id
      t.uuid   :group_id
      t.string :title
      t.text   :body
      t.string :file

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :group_id
  end
end
