module TagsHelper
  REGEXS = [[Supertag::Tag::USERTAG_REGEX, :usertag_path], 
            [Supertag::Tag::HASHTAG_REGEX, :hashtag_path], 
            [Supertag::Tag::MONEYTAG_REGEX, :moneytag_path]]

  def linkify_tags(taggable_content)
    text = taggable_content.to_s

    REGEXS.each do |regex, path|
      text = text.gsub(regex) {link_to($&, send(path, $2), class: 'tag')}
    end     

    text.html_safe
  end

  def render_taggable(taggable)
    klass        = taggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => taggable}
  end
end
