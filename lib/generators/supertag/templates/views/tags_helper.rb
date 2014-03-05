module TagsHelper
  REGEXS = [[Supertag::Usertag::USERTAG_REGEX, :usertag_path], 
            [Supertag::Hashtag::HASHTAG_REGEX, :hashtag_path], 
            [Supertag::Moneytag::MONEYTAG_REGEX, :moneytag_path]]

  def linkify_tags(taggable_content)
    text = taggable_content.to_s

    REGEXS.each do |regex, path|
      text = text.gsub(regex) {link_to($&, send(path, $2), class: 'tag')}
    end     

    text.html_safe
  end

  def render_hashtaggable(hashtaggable)
    klass        = hashtaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => hashtaggable}
  end

  def render_usertaggable(usertaggable)
    klass        = usertaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => usertaggable}
  end

  def render_moneytaggable(moneytaggable)
    klass        = moneytaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => moneytaggable}
  end
end
