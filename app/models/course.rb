class Course < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :institution
  belongs_to :coordinator, class_name: 'User', foreign_key: 'coordinator_id'
  has_many :subjects
  has_many :students
  has_many :users, through: :students

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:name, :initials, :coordinator, :institution, :description]

  # ---- delegates ----

  delegate :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :name, to: :coordinator, prefix: true, allow_nil: true

  # ---- searchkick ----

  def search_data
    {
      name: name,
      initials: initials,
      coordinator: coordinator_name,
      institution: institution_trading_name,
      description: description
    }
  end
end
