class User < ActiveRecord::Base
  # ---- devise ----

  devise :database_authenticatable, :recoverable, :registerable, :trackable,
         :timeoutable, :lockable, :validatable

  # ---- relationships ----

  belongs_to :user_type

  # ---- default values ----

  default_value_for :user_type_id, 3 # usar constantine

  # ---- delegates ----

  delegate :name, to: :user_type, prefix: true, allow_nil: true

  # ---- scoped search ----

  scoped_search on: [:email]
end
