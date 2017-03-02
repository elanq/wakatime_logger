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

  def populate_summaries(start_date = DateTime.now, end_date = DateTime.now)
    formatted_start = start_date.strftime("%F")
    formatted_end = end_date.strftime("%F")
    response = connection.get do |request|
      request.url "#{ENV['WAKATIME_SUMMARIES_URL']}"
      request.headers['Authorization'] = api_encoded
      request.params['start'] = formatted_start
      request.params['end'] = formatted_end
    end

    JSON.parse(response.body)
  end

  private

  attr_reader :api_key, :api_encoded, :connection
end
