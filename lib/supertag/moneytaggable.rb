module Supertag
  module Moneytaggable
    extend ActiveSupport::Concern

    included do
      has_many :moneytaggings, as: :moneytaggable,  class_name: "Supertag::Moneytagging", dependent: :destroy
      has_many :moneytags, through: :moneytaggings, class_name: "Supertag::Moneytag"

      before_save :update_moneytags

      def moneytaggable_content
        self.class.moneytaggable_attribute # to ensure it has been called at least once
        content = self.send(self.class.moneytaggable_attribute_name)
        content.to_s
      end

      def update_moneytags
        self.moneytags = parsed_moneytags
      end

      def parsed_moneytags
        parsed_moneytags = []
        array_of_moneytags_as_string = scan_for_moneytags(moneytaggable_content)
        array_of_moneytags_as_string.each do |s|
          parsed_moneytags << Moneytag.find_or_create_by_name(s[1])
        end
        parsed_moneytags
      end

      def scan_for_moneytags(content)
        match = content.scan(Moneytag::MONEYTAG_REGEX)
        match.uniq!
        match
      end
    end

    module ClassMethods
      attr_accessor :moneytaggable_attribute_name

      def moneytaggable_attribute(name=nil)
        self.moneytaggable_attribute_name ||= name || :body
      end
    end
  end
end