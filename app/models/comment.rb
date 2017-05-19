class Comment < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :user
  belongs_to :post

  # ---- delegates ----

  delegate :name, to: :user, prefix: true, allow_nil: true

  # ---- validates ----

  validates :content, presence: true
end
