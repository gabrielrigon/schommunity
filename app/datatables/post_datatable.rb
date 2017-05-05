class PostDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           :current_user, to: :@view

  def initialize(view)
    @view = view
    @columns = %w(created_at title post_types.name active )
  end

  protected

  def total_records
    Post.where(user_id: current_user.id).count
  end

  private

  def data
    collection.map do |item|
      [
        item.decorate.created_at,
        item.title,
        item.post_type_name,
        item.decorate.active,

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
      ids = Post.where(user_id: current_user.id)
                .search(params[:sSearch]).records
      query[:id] = ids
    end

    Post.where(user_id: current_user.id)
        .where(query).order("#{sort_column} #{sort_direction}")
        .page(page).per_page(per_page)
  end
end
