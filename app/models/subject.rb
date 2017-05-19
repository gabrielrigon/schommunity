class Subject < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:name, :initials, :course]

  # ---- delegates ----

  delegate :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true

  # ---- searchkick ----

  def search_data
    {
      name: name,
      initials: initials,
      course: course_name
    }
  end
end
