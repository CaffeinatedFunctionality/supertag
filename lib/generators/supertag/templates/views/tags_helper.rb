module TagsHelper
  def linkify_tags(taggable_content)
    regex = Supertag::Tag::USERTAG_REGEX
    tagged_content = taggable_content.to_s.gsub(regex) do
      link_to($&, tag_path($2), {class: :tag})
    end
    tagged_content.html_safe ||
    regex = Supertag::Tag::HASHTAG_REGEX
    tagged_content = taggable_content.to_s.gsub(regex) do
      link_to($&, tag_path($2), {class: :tag})
    end
    tagged_content.html_safe ||
    regex = Supertag::Tag::MONEYTAG_REGEX
    tagged_content = taggable_content.to_s.gsub(regex) do
      link_to($&, tag_path($2), {class: :tag})
    end
    tagged_content.html_safe ||
    regex = Supertag::Tag::ATTRIBUTETAG_REGEX
    tagged_content = taggable_content.to_s.gsub(regex) do
      link_to($&, tag_path($2), {class: :tag})
    end
    tagged_content.html_safe
  end

  def render_taggable(taggable)
    klass        = taggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => taggable}
  end
end
