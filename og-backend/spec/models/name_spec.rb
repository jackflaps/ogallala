require 'rails_helper'

# Test suite for the Name model
RSpec.describe Name, type: :model do
  # association tests
  it { should belong_to(:entity) }

  # validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:form) }
end
