class Post < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course
  belongs_to :subject
  belongs_to :classroom
  belongs_to :post_type
  belongs_to :user

  # ---- delegates ----

  delegate :full_name, to: :user, prefix: true, allow_nil: true
  delegate :uuid, to: :classroom, prefix: true, allow_nil: true
  delegate :name, to: :post_type, prefix: true, allow_nil: true

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:title]

  # ---- searchkick ----

  def search_data
    {
      title: title
    }
  end
end
