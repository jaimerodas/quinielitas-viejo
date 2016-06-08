module ApplicationHelper

  def field_error errors, name
    if errors[name.to_sym].first
      return "<span class=\"help error\">#{errors[name.to_sym].first.capitalize}</span>".html_safe
    end
  end

end
