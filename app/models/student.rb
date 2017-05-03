class Student < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :user
  belongs_to :institution
  belongs_to :course

  # ---- delegates ----

  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :id, :name, to: :course, prefix: true, allow_nil: true
  delegate :full_name, to: :user, prefix: true, allow_nil: true

  # ---- validates ----

  # validates :number, presence: true, uniqueness: true
end
