module SimpleUsertag
  module Usertaggable
    extend ActiveSupport::Concern

    included do
      has_many :usertaggings, as: :usertaggable,  class_name: "SimpleUsertag::Usertagging", dependent: :destroy
      has_many :usertags, through: :usertaggings, class_name: "SimpleUsertag::Usertag"

      before_save :update_usertags

      def usertaggable_content
        self.class.usertaggable_attribute # to ensure it has been called at least once
        content = self.send(self.class.usertaggable_attribute_name)
        content.to_s
      end

      def update_usertags
        self.usertags = parsed_usertags
      end

      def parsed_usertags
        parsed_usertags = []
        array_of_usertags_as_string = scan_for_usertags(usertaggable_content)
        array_of_usertags_as_string.each do |s|
          parsed_usertags << Usertag.find_or_create_by_name(s[1])
        end
        parsed_usertags
      end

      def scan_for_usertags(content)
        match = content.scan(Usertag::USERTAG_REGEX)
        match.uniq!
        match
      end
    end

    module ClassMethods
      attr_accessor :usertaggable_attribute_name

      def usertaggable_attribute(name=nil)
        self.usertaggable_attribute_name ||= name || :body
      end
    end
  end
end
