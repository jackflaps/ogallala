class Name < ApplicationRecord
  belongs_to :entity
  validates :name, presence: true
  validates :form, presence: true, inclusion: { in: %w(authorized parallel standardized other), message: "'%{value}' is not a valid name form type" }, allow_nil: false
end
