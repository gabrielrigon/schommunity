class Student < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :user
  belongs_to :institution

  # ---- delegates ----

  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :full_name, to: :user, prefix: true, allow_nil: true
end
