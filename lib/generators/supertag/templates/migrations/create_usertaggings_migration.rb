# This migration comes from simple_usertag
class CreateSimpleUsertagUsertaggings < ActiveRecord::Migration
  def change
    create_table :simple_usertag_usertaggings do |t|
      t.references :usertag,      :index => true
      t.references :usertaggable, :polymorphic => true
    end
    add_index :simple_usertag_usertaggings, ["usertaggable_id", "usertaggable_type"],
              :name => 'index_usertaggings_usertaggable_id_usertaggable_type'
  end
end
