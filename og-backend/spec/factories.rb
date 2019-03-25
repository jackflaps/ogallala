FactoryBot.define do
  factory :entity, class: Entity do
    record_status { "draft" }
    cataloging_level { "partial" }
    cataloging_language { "eng" }

    trait :person do
      entity_type { "person" }
      before :create do |entity|
        entity.names = create_list :name, 1, :name_person, entity: entity
      end
    end

    trait :corporate_body do
      entity_type { "corporate_body" }
      before :create do |entity|
        entity.names = create_list :name, 1, :name_corporate_body, entity: entity
      end
    end

    trait :family do
      entity_type { "family" }
      before :create do |entity|
        entity.names = create_list :name, 1, :name_family, entity: entity
      end
    end
  end

  factory :name do
    form { "authorized" }

    trait :name_person do
      name { Faker::FunnyName.two_word_name }
    end

    trait :name_corporate_body do
      name { Faker::Company.name }
    end

    trait :name_family do
      name { "#{Faker::Name.last_name} family" }
    end
  end

  factory :user do
    name { Faker::Name.name }
    email { "admin@example.com" }
    password { "nebraska" }
  end
end
