require 'rails_helper'

# Test suite for the Entity model
RSpec.describe Entity, type: :model do
  # association tests
  it { should have_many(:names).dependent(:destroy) }

  # validation tests
  it { should validate_presence_of(:entity_type) }
end
