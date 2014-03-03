module UsertagsHelper
  def linkify_usertags(usertaggable_content)
    regex = SimpleUsertag::Usertag::USERTAG_REGEX
    usertagged_content = usertaggable_content.to_s.gsub(regex) do
      link_to($&, usertag_path($2), {class: :usertag})
    end
    usertagged_content.html_safe
  end

  def render_usertaggable(usertaggable)
    klass        = usertaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => usertaggable}
  end
end
