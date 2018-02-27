class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships, id: :uuid do |t|

      t.uuid :user_id
      t.uuid :group_id

      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :group_id
  end
end
