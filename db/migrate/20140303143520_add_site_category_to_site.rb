class AddSiteCategoryToSite < ActiveRecord::Migration
  def change
    change_table :site_framework_sites do |t|
      t.integer :site_category_id
    end
  end
end
