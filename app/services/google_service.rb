class GoogleService
  def get_video_from_query(searched_for_country)
    get_url("/youtube/v3/search?q=#{searched_for_country}")
  end

  def get_url(url)
    response = api_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_connection
    Faraday.new(
      url: 'https://youtube.googleapis.com',
      params: {
        part: 'snippet',
        channelId: 'UCluQ5yInbeAkkeCndNnUhpw',
        key: Rails.application.credentials.google[:key]
      },
      headers: {'Content-Type' => 'application/json'}
    )
  end
end