class CourseDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           :current_ability, to: :@view

  def initialize(view)
    @view = view
    @columns = %w(name initials coordinators.name)
  end

  protected

  def total_records
    Course.accessible_by(current_ability).count
  end

  private

  def data
    collection.map do |item|
      [
        item.name,
        item.initials,
        item.coordinator_name,

        content_tag(:div, class: 'btn-group') do
          link_to('javascript:;', class: 'btn btn-default btn-sm') do
            'Ações'
          end +

          link_to('javascript:;', class: 'btn btn-default btn-sm dropdown-toggle', data: { toggle: 'dropdown' }) do
            content_tag(:span, class: 'fa fa-caret-down') {}
          end +

          content_tag(:ul, class: 'dropdown-menu pull-right') do
            content_tag(:li) do
              link_to resource_path(item) do
                content_tag(:i, class: 'fa fa-eye') {} +
                ' Detalhes'
              end
            end +

            content_tag(:li) do
              link_to edit_resource_path(item) do
                content_tag(:i, class: 'fa fa-pencil') {} +
                ' Editar'
              end
            end +

            content_tag(:li) do
              link_to resource_path(item), method: :delete, data: { confirm: 'Confirma?' } do
                content_tag(:i, class: 'fa fa-trash-o') {} +
                ' Excluir'
              end
            end
          end
        end
      ]
    end
  end
  #

  def fetch_collection
    query = {}

    if params[:sSearch].present?
      ids = Course.accessible_by(current_ability).search_for(params[:sSearch]).ids
      query[:id] = ids
    end

    Course.accessible_by(current_ability)
          .joins(:coordinator).includes(:coordinator)
          .where(query).order("#{sort_column} #{sort_direction}")
          .page(page).per_page(per_page)
  end
end
