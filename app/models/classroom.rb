class Classroom < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course
  belongs_to :subject
  belongs_to :classroom_time
  belongs_to :representative, class_name: 'User', foreign_key: 'representative_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :classroom_users
  has_many :users, through: :classroom_users

  # ---- delegates ----

  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :initials, :name, to: :course, prefix: true, allow_nil: true
  delegate :initials, :name, to: :subject, prefix: true, allow_nil: true
  delegate :initial, :name, to: :classroom_time, prefix: true, allow_nil: true
  delegate :name, to: :representative, prefix: true, allow_nil: true
  delegate :name, to: :teacher, prefix: true, allow_nil: true

  # ---- virtual attributes ----

  attr_accessor :user_token

  # ---- callbacks ----

  after_create :create_uuid

  # ---- nested values ----

  accepts_nested_attributes_for :classroom_users, allow_destroy: true

  # ---- default values ----

  default_value_for :active, true

  # ---- validates ----

  validate :user_uniqueness

  # ---- methods ----

  def create_uuid
    self.uuid = "#{course_initials}-#{subject_initials}-#{classroom_time_initial}-#{id}"
    save
  end

  private

  def user_uniqueness
    validate_uniqueness_of_in_memory(
      classroom_users, [:user_id],
      'Existem alunos duplicados'
    )
  end
end
