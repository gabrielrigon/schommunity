class User < ActiveRecord::Base
  # ---- devise ----

  devise :database_authenticatable, :invitable, :recoverable, :registerable,
         :trackable, :timeoutable

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:name, :email, :institution]

  # ---- relationships ----

  belongs_to :user_type
  belongs_to :institution
  belongs_to :gender
  has_many :courses, as: :coordinator
  has_many :classrooms, as: :teacher
  has_one :address, as: :linkable, dependent: :destroy
  has_one :student, dependent: :destroy

  # ---- paperclip ----

  has_attached_file :avatar, styles: {
    thumb:  '60x60#',
    medium: '120x120#',
    large:  '230x230#'
  }, default_url: '/vendor/images/img_placeholder.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # ---- validates ----

  validates :institution, presence: true
  validates :user_type, presence: true
  validates :cpf, presence: true, uniqueness: true, length: { is: 14 } # mudar para 11 sem mascara
  validates :email, presence: true, uniqueness: true

  # ---- callbacks ----

  after_create :invite
  after_save   :update_student

  # ---- nested values ----

  accepts_nested_attributes_for :address

  # ---- virtual attributes ----

  attr_accessor :attribute_student_number

  # ---- default values ----

  default_value_for :user_type_id, invoke(UserType, :student)

  # ---- delegates ----

  delegate :name, to: :user_type, prefix: true, allow_nil: true
  delegate :name, to: :gender, prefix: true, allow_nil: true
  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true
  delegate :number, to: :student, prefix: true, allow_nil: true

  # ---- scope ----

  scope :valid, -> { where.not(id: 1) }
  scope :students, -> { where(user_type_id: invoke(UserType, :student)) }
  scope :teachers, -> { where(user_type_id: invoke(UserType, :teacher)) }

  # ---- aliases ----

  alias_attribute :name, :full_name

  # ---- methods ----

  def full_name
    "#{first_name} #{last_name}"
  end

  def invite
    invite! if encrypted_password.blank?
  end

  def coordinated_courses_ids
    courses_ids = Course.where(coordinator_id: id).pluck(:id)
    courses_ids << nil # not ok
    courses_ids.presence
  end

  def attribute_student_number
    student.present? ? student_number : ''
  end

  def update_student
    if user_type_id == invoke(UserType, :student)
      if student.present?
        student.update_attributes(number: @attribute_student_number)
      else
        Student.create(user: self, institution: institution,
                       number: @attribute_student_number)
      end
    else
      return unless student.present?
      student.destroy
    end
  end

  # ---- user types ----

  def admin?
    user_type_id == invoke(UserType, :admin)
  end

  def schoolmaster?
    user_type_id == invoke(UserType, :schoolmaster)
  end

  def coordinator?
    coordinated_courses_ids.any?
  end

  def teacher?
    user_type_id == invoke(UserType, :teacher)
  end

  def student?
    user_type_id == invoke(UserType, :student)
  end

  # ---- searchkick ----

  def search_data
    {
      name: full_name,
      email: email,
      institution: institution_trading_name
    }
  end
end
