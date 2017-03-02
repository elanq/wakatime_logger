class CodingActivity
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  field :project_name, type: String
  field :activity_collection, type: Array

  def self.save_response(response)
    editors = response['data'].first
    projects = editors['projects']
    projects.each do |project|
      coding_activity = CodingActivity.find_or_create_by(project_name: project['name'])
      coding_activity.project_name = project['name']
      value = {total_seconds: project['total_seconds'], collection_time: Time.now.to_i}
      coding_activity.push(activity_collection: value)

      coding_activity.save!
    end
  end
end
