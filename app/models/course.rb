class Course < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :coordinator, class_name: 'User', foreign_key: 'coordinator_id'
  has_many :subjects

  # ---- delegates ----

  delegate :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :name, to: :coordinator, prefix: true, allow_nil: true
end
