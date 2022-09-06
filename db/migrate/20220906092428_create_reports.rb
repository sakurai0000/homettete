class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.boolean :report_status, null: false, default: true

      t.timestamps
    end
  end
end
