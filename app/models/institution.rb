class Institution < ActiveRecord::Base
  # ---- relationships ----

  has_one :address

  # ---- delegates -----

  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- scoped search ----

  scoped_search on: [:name]
end
