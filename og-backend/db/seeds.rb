# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

params = {}

corporate_body_names = [
  {name: "University of Denver", form: "authorized"},
  {name: "Denver (Colo.). University of Denver", form: "other"},
  {name: "DU ((Colo.) University)", form: "other"},
  {name: "Universität Denver", form: "parallel"}
]

person_names = [
  {name: "Lowenstein, Henry, 1925-2014", form: "authorized"},
  {name: "Lowenstein, Heinrich", form: "other"},
  {name: "Lowenstein, Ernst Heinrich", form: "other"}
]

params[:entity] = {entity_type: "corporate_body", record_status: "draft", cataloging_level: "partial", cataloging_language: "eng", bioghist: "The University of Denver (DU) is a private research university in Denver, Colorado. Founded in 1864, it is the oldest independent private university in the Rocky Mountain Region of the United States.", names_attributes: corporate_body_names}
Entity.create(params[:entity])

params[:entity] = {entity_type: "person", record_status: "draft", cataloging_level: "partial", cataloging_language: "eng", names_attributes: person_names}
Entity.create(params[:entity])

params[:entity] = {entity_type: "person", record_status: "draft", cataloging_level: "partial", cataloging_language: "eng", bioghist: "David Hastings Moore (September 4, 1838 – November 23, 1915) was an American bishop of the Methodist Episcopal Church, elected in 1900. He also gained notability as a Union Army officer in the American Civil War, as a pastor, as the editor of an important Methodist periodical, and as a university chancellor.", names_attributes: [{name: "Moore, David Hastings", form: "authorized"}]}
Entity.create(params[:entity])

params[:entity] = {entity_type: "family", record_status: "draft", cataloging_level: "partial", cataloging_language: "eng", names_attributes: [{name: "Lowenstein family", form: "authorized"}]}
Entity.create(params[:entity])

User.create({name: "Admin User", email: "admin@example.com", password: "nebraska", password_confirmation: "nebraska"})
