class RemoveColumeUsersRelationship < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :relationship_id, :bigint

  end
end
