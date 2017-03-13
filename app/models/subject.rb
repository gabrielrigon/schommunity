class Subject < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:name, :initials, :institution, :course, :description]

  # ---- delegates ----

  delegate :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true

  # ---- searchkick ----

  def search_data
    {
      name: name,
      initials: initials,
      institution: institution_trading_name,
      course: course_name,
      description: description
    }
  end
end
