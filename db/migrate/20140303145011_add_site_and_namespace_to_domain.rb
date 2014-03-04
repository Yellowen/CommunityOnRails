class AddSiteAndNamespaceToDomain < ActiveRecord::Migration
  def change
    change_table :site_framework_domains do |t|
      t.integer :namespace_id
    end
  end
end
