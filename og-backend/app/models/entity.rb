class Entity < ApplicationRecord
  has_many :names, :dependent => :destroy
  accepts_nested_attributes_for :names, allow_destroy: true

  before_save :set_authorized_name

  validates_presence_of :names

  validates :entity_type, presence: true, inclusion: { in: %w(corporate_body person family), message: "'%{value}' is not a valid entity type" }
  validates :record_status, inclusion: { in: %w(draft finalized revised deleted), message: "'%{value}' is not a valid record status" }, allow_nil: true
  validates :cataloging_level, inclusion: { in: %w(minimal partial full), message: "'%{value}' is not a valid cataloging level" }, allow_nil: true

  validate :name_is_authorized

  def name_is_authorized
    authorized_names = names.select{|n| n['form'] == "authorized"}
    if authorized_names.length == 0
      errors.add(:names, "Entity must have one authorized form of name")
    elsif authorized_names.length > 1
      errors.add(:names, "Entity may only have one authorized form of name")
    end
  end

  def set_authorized_name
    self.authorized_name = self.names.select{|n| n['form'] == "authorized"}.first['name']
  end
end
