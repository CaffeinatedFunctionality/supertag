# This migration comes from simple_usertag
class CreateSupertagTags < ActiveRecord::Migration
  def change
    create_table :supertag_tags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end
