# This migration comes from site_framework (originally 20140303141448)
class CreateSiteFrameworkSites < ActiveRecord::Migration
  def change
    create_table :site_framework_sites do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
