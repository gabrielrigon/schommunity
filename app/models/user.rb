class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :registerable, :trackable,
         :timeoutable, :lockable, :validatable, resend_invitation: true
end
