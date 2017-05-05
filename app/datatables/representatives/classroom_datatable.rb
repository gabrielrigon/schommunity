class Representatives::ClassroomDatatable < BaseDatatable
  delegate :content_tag, :params, :link_to, :resource_path, :edit_resource_path,
           :members_representatives_classroom_path, :current_user, to: :@view

  def initialize(view)
    @view = view
    @columns = %w(uuid subjects.name classroom_times.name teachers.name)
  end

  protected

  def total_records
    Classroom.where(id: current_user.represented_classrooms_ids).count
  end

  private

  def data
    collection.map do |item|
      [
        item.uuid,
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
              link_to members_representatives_classroom_path(item) do
                content_tag(:i, class: 'fa fa-users') {} +
                ' Membros'
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
      ids = Classroom.where(id: current_user.represented_classrooms_ids)
                     .search(params[:sSearch]).records
      query[:id] = ids
    end

    Classroom.where(id: current_user.represented_classrooms_ids)
             .joins(:subject.outer, :classroom_time.outer, :teacher.outer)
             .includes(:subject, :classroom_time, :teacher)
             .where(query).order("#{sort_column} #{sort_direction}")
             .page(page).per_page(per_page)
  end
end
