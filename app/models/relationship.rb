class Relationship < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :related_from, foreign_key: "entity_id_0", class_name: "Entity"
  belongs_to :related_to, foreign_key: "entity_id_1", class_name: "Entity"

  validates :relationship_type, presence: true, inclusion: { in: %w(hierarchical temporal associative), message: "'%{value}' is not a valid relationship type" }

  # relator validations
  validates :relator, presence: true
  validates :relator, inclusion: { in: %w(is_superior_of is_subordinate_to), message: "'%{value} is not a valid relator'" }, if: :hierarchical?
  validates :relator, inclusion: { in: %w(earlier_form_of later_form_of), message: "'%{value} is not a valid relator'" }, if: :temporal?
  validates :relator, inclusion: { in: %w(is_associative_with), message: "'%{value} is not a valid relator'" }, if: :associative?

  def hierarchical?
    relationship_type == "hierarchical"
  end

  def temporal?
    relationship_type == "temporal"
  end

  def associative?
    relationship_type == "associative"
  end
end
