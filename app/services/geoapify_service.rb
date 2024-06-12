class GeoapifyService
  def get_coordinates_from_query(searched_for_country)
    get_url("/v1/geocode/search?text=#{searched_for_country}&type=country&format=json")
  end

  def get_tourist_sites_from_coordinates(latitude, longitude)
    get_url("/v2/places?&categories=tourism&bias=proximity:#{longitude},#{latitude}") # It looks like these are flipped but it's just the way the Geoapify orders them in the URL
  end

  def get_url(url)
    response = api_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_connection
    Faraday.new(
      url: 'https://api.geoapify.com',
      params: {
        apiKey: Rails.application.credentials.geoapify[:key]
      },
      headers: {'Content-Type' => 'application/json'}
    )
  end
end