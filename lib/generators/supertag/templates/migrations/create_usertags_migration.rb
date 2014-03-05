# This migration comes from supertag
class CreateSupertagUsertags < ActiveRecord::Migration
  def change
    create_table :supertag_usertags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end