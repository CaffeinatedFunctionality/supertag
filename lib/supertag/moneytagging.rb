module Supertag
  class Moneytagging < ActiveRecord::Base
    self.table_name = "supertag_moneytaggings"

    belongs_to :moneytag
    belongs_to :moneytaggable, polymorphic: true
  end
end