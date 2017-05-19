class UserChat < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :user
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'

  # ---- delegates ----

  delegate :name, :first_name, to: :user, prefix: true, allow_nil: true
  delegate :name, :first_name, to: :contact, prefix: true, allow_nil: true

  # ---- default values ----

  default_value_for :read, false
end
