class CreateGreats < ActiveRecord::Migration[6.1]
  def change
    create_table :greats do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
