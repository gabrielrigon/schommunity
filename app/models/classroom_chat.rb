class ClassroomChat < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :classroom
  belongs_to :user

  # ---- delegates ----

  delegate :name, to: :user, prefix: true, allow_nil: true
end
