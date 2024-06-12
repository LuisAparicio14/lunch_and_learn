class UnsplashService
  def get_images_from_query(searched_for_country)
    get_url("/search/photos?query=#{searched_for_country}")
  end

  def get_url(url)
    response = api_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_connection
    Faraday.new(
      url: 'https://api.unsplash.com',
      params: {
        client_id: Rails.application.credentials.unsplash[:key]
      },
      headers: {'Content-Type' => 'application/json'}
    )
  end
end