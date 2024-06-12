class RestCountriesService
  def all_countries
    get_url('/v3.1/all')
  end

  def get_url(url)
    response = api_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_connection
    Faraday.new(url: 'https://restcountries.com')
  end
end