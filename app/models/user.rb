class User < ActiveRecord::Base
  # ---- devise ----

  devise :database_authenticatable, :invitable, :recoverable, :registerable,
         :trackable, :timeoutable#, :validatable

  # ---- relationships ----

  belongs_to :user_type
  belongs_to :institution
  belongs_to :gender
  has_many :courses, as: :coordinator
  has_one :address, as: :linkable, dependent: :destroy

  # ---- validates ----

  validates :institution, presence: true
  validates :user_type, presence: true
  validates :cpf, presence: true, uniqueness: true, length: { is: 14 } # mudar para 11 sem mascara
  validates :email, presence: true, uniqueness: true

  # ---- callbacks ----

  after_create :invite

  # ---- nested values ----

  accepts_nested_attributes_for :address

  # ---- default values ----

  default_value_for :user_type_id, invoke(UserType, :student)

  # ---- delegates ----

  delegate :name, to: :user_type, prefix: true, allow_nil: true
  delegate :name, to: :gender, prefix: true, allow_nil: true
  delegate :id, :trading_name, to: :institution, prefix: true, allow_nil: true
  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- scoped search ----

  scoped_search on: [:first_name, :last_name, :email]

  # ---- scope ----

  scope :valid, -> { where.not(first_name: '') }

  # ---- aliases ----

  alias_attribute :name, :full_name

  # ---- methods ----

  def full_name
    "#{first_name} #{last_name}"
  end

  def invite
    invite!
  end

  # ---- user types ----

  def admin?
    user_type_id == invoke(UserType, :admin)
  end

  def schoolmaster?
    user_type_id == invoke(UserType, :schoolmaster)
  end

  def coordinator?
    user_type_id == invoke(UserType, :coordinator)
  end
end
