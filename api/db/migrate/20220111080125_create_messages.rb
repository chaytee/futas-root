class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user
      t.string :content
      t.integer :priority

      t.timestamps
    end
  end
end
