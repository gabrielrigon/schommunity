class Institution < ActiveRecord::Base
  # ---- relationships ----

  has_one :address, as: :linkable, dependent: :destroy
  has_many :courses
  has_many :subjects
  has_many :students

  # ---- searchkick ----

  searchkick match: :word_start, searchable: [:trading_name, :company_name, :cnpj]

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

  # ---- aliases ----

  alias_attribute :name, :trading_name

  # ---- scope ----

  scope :valid, -> { where.not(id: 1) }

  # ---- searchkick ----

  def search_data
    {
      trading_name: trading_name,
      company_name: company_name,
      cnpj: cnpj
    }
  end
end
