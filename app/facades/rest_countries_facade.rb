class RestCountriesFacade
  def get_list_of_all_countries
    service = RestCountriesService.new
    response = service.all_countries.map do |country|
      country[:name][:common]
    end
  end
end