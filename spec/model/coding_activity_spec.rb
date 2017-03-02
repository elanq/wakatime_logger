require_relative '../spec_helper.rb'

RSpec.describe CodingActivity do
  it{ is_expected.to respond_to(:project_name) }
  it{ is_expected.to respond_to(:activity_time) }
  it{ is_expected.to respond_to(:collection_date) }
end
