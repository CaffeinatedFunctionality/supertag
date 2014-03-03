module SimpleUsertag
  class Usertagging < ActiveRecord::Base
    self.table_name = "simple_usertag_usertaggings"

    belongs_to :usertag
    belongs_to :usertaggable, polymorphic: true
  end
end
