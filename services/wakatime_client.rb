class WakatimeClient
  require 'base64'
  require 'faraday'

  def initialize
    api_key = ENV['WAKATIME_API_KEY']
    @api_encoded = Base64.encode64(api_key)
    @connection = ::Faraday.new(url: ENV['WAKATIME_HOST']) do |faraday|
                    faraday.adapter   Faraday.default_adapter
                    faraday.response  :logger
                  end
  end

  def populate_durations(date = DateTime.now)
    formatted_date = date.strftime("%F")
    response = connection.get do |request|
      request.url "#{ENV['WAKATIME_DURATION_URL']}"
      request.headers['Authorization'] = api_encoded
      request.params['date'] = formatted_date
    end

    puts response.body
  end

  private

  attr_reader :api_key, :api_encoded, :connection
end
