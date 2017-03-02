class CodingActivity
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  field :project_name, type: String
  field :activity_time, type: Integer
  field :collection_date, type: Integer

  def self.save_response(response)
    editors = response['data'].first
    projects = editors['projects']
    projects.each do |project|
      coding_activity = CodingActivity.find_or_create_by(project_name: project['name'])
      coding_activity.project_name = project['name']
      coding_activity.activity_time = project['total_seconds']
      coding_activity.collection_date = Time.now.to_i

      coding_activity.save!
    end
  end
end
