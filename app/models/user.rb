class User < ApplicationRecord
  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks

  has_secure_password

  validates :name, presence: true, uniqueness: true, allow_nil: false
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, allow_nil: false
  validates :password, presence: true, length: { minimum: 8 }
end
