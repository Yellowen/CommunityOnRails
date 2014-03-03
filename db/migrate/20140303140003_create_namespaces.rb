class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
