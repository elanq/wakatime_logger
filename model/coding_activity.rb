class CodingActivity
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  field :project_name, type: String
  field :activity_time, type: Integer
  field :collection_date, type: DateTime
end
