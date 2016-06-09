module ApplicationHelper

  def field_error errors, name
    if errors[name.to_sym].first
      return "<span class=\"help error\">#{errors[name.to_sym].first.capitalize}</span>".html_safe
    end
  end

  def icon name, options={}
    file = File.read(Rails.root.join('icons', "#{name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file

    classes = options[:class] || 'icon'
    size = options[:size] || 32

    svg = doc.at_css 'svg'
    svg['class'] = classes
    svg['width'] = size
    svg['height'] = size

    doc.to_html.html_safe
  end

end
