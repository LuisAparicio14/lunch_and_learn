class EdamamService
  def get_recipes_from_query(searched_for_country)
    get_url("/api/recipes/v2?type=public&q=#{searched_for_country}")
  end

  def get_url(url)
    response = api_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_connection
    Faraday.new(
      url: 'https://api.edamam.com',
      params: {
        app_id: '08e8c11c',
        app_key: Rails.application.credentials.edamam[:key]
      },
      headers: {'Content-Type' => 'application/json'}
    )
  end
end