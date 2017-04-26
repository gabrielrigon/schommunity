class Classroom < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course
  belongs_to :subject
  belongs_to :classroom_time
  belongs_to :representative, class_name: 'User', foreign_key: 'representative_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  # ---- delegates ----

  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :initials, :name, to: :course, prefix: true, allow_nil: true
  delegate :initials, :name, to: :subject, prefix: true, allow_nil: true
  delegate :initial, :name, to: :classroom_time, prefix: true, allow_nil: true
  delegate :name, to: :representative, prefix: true, allow_nil: true
  delegate :name, to: :teacher, prefix: true, allow_nil: true

  # ---- callbacks ----

  after_create :create_uuid

  # ---- default values ----

  default_value_for :active, true

  # ---- methods ----

  def create_uuid
    self.uuid = "#{course_initials}-#{subject_initials}-#{classroom_time_initial}-#{id}"
    save
  end
end
