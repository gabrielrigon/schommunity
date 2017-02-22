module ApplicationHelper

  def resource_title
    t("resources.#{resource_class.to_s.underscore}.title")
  end

  def resource_description
    t("resources.#{resource_class.to_s.underscore}.description")
  end

  def menu_label_icon(label, icon)
    content_tag(:i, class: "fa fa-#{icon}") {} +
      content_tag(:span) do
        label
      end
  end
end
