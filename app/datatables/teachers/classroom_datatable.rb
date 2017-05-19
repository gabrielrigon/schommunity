class Teachers::ClassroomDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           :members_teachers_classroom_path, :current_ability, :current_user,
           to: :@view

  def initialize(view)
    @view = view
    @columns = %w(uuid courses.name subjects.name classroom_times.name users.name)
  end

  protected

  def total_records
    Classroom.accessible_by(current_ability).count
  end

  private

  def data
    collection.map do |item|
      [
        item.uuid,
        item.course_name,
        item.subject_name,
        item.classroom_time_name,
        item.teacher_name,

        content_tag(:div, class: 'btn-group') do
          link_to('javascript:;', class: 'btn btn-default btn-sm') do
            'Ações'
          end +

          link_to('javascript:;', class: 'btn btn-default btn-sm dropdown-toggle', data: { toggle: 'dropdown' }) do
            content_tag(:span, class: 'fa fa-caret-down') {}
          end +

          content_tag(:ul, class: 'dropdown-menu pull-right') do
            content_tag(:li) do
              link_to members_teachers_classroom_path(item) do
                content_tag(:i, class: 'fa fa-users') {} +
                ' Membros'
              end
            end +

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
      ids = Classroom.accessible_by(current_ability)
                     .search(params[:sSearch]).records
      query[:id] = ids
    end

    Classroom.accessible_by(current_ability)
             .joins(:course.outer, :subject.outer, :classroom_time.outer, :teacher.outer)
             .includes(:course, :subject, :classroom_time, :teacher)
             .where(query).order("#{sort_column} #{sort_direction}")
             .page(page).per_page(per_page)
  end
end
