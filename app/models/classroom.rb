class Classroom < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course
  belongs_to :subject
  belongs_to :classroom_time
  belongs_to :representative, class_name: 'User', foreign_key: 'representative_id'

  # ---- delegates ----

  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :initials, :name, to: :course, prefix: true, allow_nil: true
  delegate :initials, :name, to: :subject, prefix: true, allow_nil: true
  delegate :name, to: :classroom_time, prefix: true, allow_nil: true
  delegate :name, to: :representative, prefix: true, allow_nil: true

  # ---- callbacks ----

  after_create :create_uuid

  # ---- methods ----

  def create_uuid
    self.uuid = "##{id}"
    save
  end
end
