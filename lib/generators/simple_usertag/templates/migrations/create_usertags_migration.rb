# This migration comes from simple_usertag
class CreateSimpleUsertagUsertags < ActiveRecord::Migration
  def change
    create_table :simple_usertag_usertags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end
