class City < ActiveRecord::Base
  # ---- relationships ----
  
  belongs_to :state
  has_many :addresses
end
