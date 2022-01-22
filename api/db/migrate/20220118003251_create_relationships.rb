class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|

      t.references :user
      t.string :paircode, unique: true
      t.timestamps
    end
  end
end
