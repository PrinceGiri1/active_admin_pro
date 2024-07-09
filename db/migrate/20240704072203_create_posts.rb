class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :read_count, default: 0
      t.boolean :approved_by_admin, default: false

      t.timestamps
    end
  end
end
