class Post < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :course
  belongs_to :subject
  belongs_to :classroom
  belongs_to :post_type
  belongs_to :user
  has_many :comments, dependent: :destroy

  # ---- delegates ----

  delegate :full_name, to: :user, prefix: true, allow_nil: true
  delegate :uuid, :name, to: :classroom, prefix: true, allow_nil: true
  delegate :name, to: :post_type, prefix: true, allow_nil: true

  # ---- default values ----

  default_value_for :active, true

  # ---- callbacks ----

  after_create :complete_data

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:title]

  # ---- validates ----

  validates :classroom, :post_type, :title, :content, presence: true

  # ---- nested values ----

  accepts_nested_attributes_for :comments

  # ---- methods ----

  def complete_data
    self.course = classroom.course
    self.subject = classroom.subject
    save
  end

  # ---- searchkick ----

  def search_data
    {
      title: title
    }
  end
end
