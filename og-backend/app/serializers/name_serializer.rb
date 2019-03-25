class NameSerializer < ActiveModel::Serializer
  attributes :id, :name, :form
  
  belongs_to :entity
end
