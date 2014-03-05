module Supertag
  class Usertagging < ActiveRecord::Base
    self.table_name = "supertag_usertaggings"

    belongs_to :usertag
    belongs_to :usertaggable, polymorphic: true
  end
end
