module Config
  require 'mongoid'
  require 'dotenv'
  require 'pry-byebug'

  require_relative '../services/wakatime_client.rb'
  module_function

  def load
    current_dir = File.dirname(__FILE__)
    ::Mongoid.load!("#{current_dir}/mongoid.yml", :development)
    ::Dotenv.load
    @wakatime ||= ::WakatimeClient.new
  end

  def wakatime
    @wakatime
  end

end
