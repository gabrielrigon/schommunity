class Institution < ActiveRecord::Base
  # ---- relationships ----

  has_one :address

  # ---- delegates -----

  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- nested values ----

  accepts_nested_attributes_for :address

  # ---- scoped search ----

  scoped_search on: [:trading_name, :company_name]
end
