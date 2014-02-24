class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.string :theme, :default => "default"

      t.timestamps
    end

    add_index :settings, :user_id
  end
end
