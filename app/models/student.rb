class Student < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :user
  belongs_to :institution
end
