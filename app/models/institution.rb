class Institution < ActiveRecord::Base
  # ---- relationships ----

  has_one :address, as: :linkable, dependent: :destroy
  has_many :courses

  # ---- paperclip ----

  has_attached_file :logo, styles: {
    thumb:  '60x60#',
    medium: '120x120#',
    large:  '230x230#'
  }, default_url: '/vendor/images/img_placeholder.png'

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  # ---- delegates -----

  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- nested values ----

  accepts_nested_attributes_for :address

  # ---- scoped search ----

  scoped_search on: [:trading_name, :company_name]

  # ---- aliases ----

  alias_attribute :name, :trading_name

  # ---- scope ----

  scope :valid, -> { where.not(id: 1) }
end
