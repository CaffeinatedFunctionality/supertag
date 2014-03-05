# This migration comes from supertag
class CreateSupertagMoneytaggings < ActiveRecord::Migration
  def change
    create_table :supertag_moneytaggings do |t|
      t.references :moneytag,      :index => true
      t.references :moneytaggable, :polymorphic => true
    end
    add_index :supertag_moneytaggings, ["moneytaggable_id", "moneytaggable_type"],
              :name => 'index_moneytaggings_moneytaggable_id_moneytaggable_type'
  end
end
