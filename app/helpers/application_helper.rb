module ApplicationHelper

  def resource_title
    t("resources.#{resource_class.to_s.underscore}.title")
  end

  def resource_description
    t("resources.#{resource_class.to_s.underscore}.description")
  end

end
