module Supertag
  module Taggable
    extend ActiveSupport::Concern

    included do
      has_many :taggings, as: :taggable,  class_name: "Supertag::Tagging", dependent: :destroy
      has_many :tags, through: :taggings, class_name: "Supertag::Tag"

      before_save :update_tags

      def taggable_content
        self.class.taggable_attribute # to ensure it has been called at least once
        content = self.send(self.class.taggable_attribute_name)
        content.to_s
      end

      def update_tags
        self.tags = parsed_tags
      end

      def parsed_tags
        parsed_tags = []
        array_of_tags_as_string = scan_for_tags(taggable_content)
        array_of_tags_as_string.each do |s|
          parsed_tags << Tag.find_or_create_by_name(s[1])
        end
        parsed_tags
      end

      def scan_for_tags(content)
        match1 = content.scan(Tag::USERTAG_REGEX) ||
        match2 = content.scan(Tag::HASHTAG_REGEX) ||
        match3 = content.scan(Tag::ATTRIBUTETAG_REGEX) ||
        match4 = content.scan(Tag::MONEYTAG_REGEX) ||
        match1.uniq!
        match2.uniq!
        match3.uniq!
        match4.uniq!
        match1
        match2
        match3
        match4
      end
    end

    module ClassMethods
      attr_accessor :taggable_attribute_name

      def taggable_attribute(name=nil)
        self.taggable_attribute_name ||= name || :body
      end
    end
  end
end
