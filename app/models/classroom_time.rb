class ClassroomTime < ActiveRecord::Base
  # ---- relationships ----

  has_many :classrooms
end
