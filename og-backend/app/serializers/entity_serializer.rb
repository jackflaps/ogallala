class EntitySerializer < ActiveModel::Serializer
  attributes :id, :authorized_name, :entity_type, :bioghist, :legal_status, :cataloging_level, :record_status, :cataloging_language

  has_many :names
end
