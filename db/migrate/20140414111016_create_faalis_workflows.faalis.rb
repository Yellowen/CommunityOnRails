# This migration comes from faalis (originally 20140413180202)
class CreateFaalisWorkflows < ActiveRecord::Migration
  def change
    create_table :faalis_workflows do |t|
      t.string :name

      t.timestamps
    end
  end
end
