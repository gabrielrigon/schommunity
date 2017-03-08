class Subject < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course

  # ---- delegates ----

  delegate :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true
end
