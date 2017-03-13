class UserDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           to: :@view

  def initialize(view)
    @view = view
    @columns = %w(name email institutions.trading_name user_types.name)
  end

  protected

  def total_records
    User.valid.count
  end

  private

  def data
    collection.map do |item|
      [
        item.name,
        item.email,
        item.institution_trading_name,
        item.user_type_name,

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
      ids = User.valid.search(params[:sSearch]).records.ids
      query[:id] = ids
    end

    User.valid.joins(:institution, :user_type).includes(:institution, :user_type)
        .where(query).order("#{sort_column} #{sort_direction}")
        .page(page).per_page(per_page)
  end
end
