class User < ActiveRecord::Base
  # ---- devise ----
  devise :database_authenticatable, :recoverable, :registerable, :trackable,
         :timeoutable, :lockable, :validatable

  # ---- relationships ----
  belongs_to :user_type
end
