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

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :uuid, :name, to: :classroom, prefix: true, allow_nil: true
  delegate :name, to: :post_type, prefix: true, allow_nil: true

  # ---- paperclip ----

  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

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

  # ---- callbacks ----

  after_save :update_attachment

  # ---- scope ----

  scope :valid, -> { where(active: true) }

  # ---- methods ----

  def complete_data
    self.course = classroom.course
    self.subject = classroom.subject
    save
  end

  def update_attachment
  return if post_type_id == invoke(PostType, :material)
  update_column(:attachment_file_name, nil)
  update_column(:attachment_content_type, nil)
  update_column(:attachment_file_size, nil)
  update_column(:attachment_updated_at, nil)
  end

  # ---- searchkick ----

  def search_data
    {
      title: title
    }
  end
end
