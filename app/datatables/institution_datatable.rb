class InstitutionDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           :current_ability, to: :@view

  def initialize(view)
    @view = view
    @columns = %w(institutions.trading_name cities.name states.name)
  end

  protected

  def total_records
    Institution.accessible_by(current_ability).valid.count
  end

  private

  def data
    collection.map do |item|
      [
        item.trading_name,
        item.address_city_name,
        item.address_state_name,

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
      ids = Institution.accessible_by(current_ability).valid.search(params[:sSearch]).records.ids
      query[:id] = ids
    end

    Institution.accessible_by(current_ability)
               .valid.joins(:address).includes(address: { city: :state })
               .where(query).order("#{sort_column} #{sort_direction}")
               .page(page).per_page(per_page)
  end
end
