class EdamamFacade
  def get_recipes(searched_for_country)
    service = EdamamService.new
    response = service.get_recipes_from_query(searched_for_country)
    create_poro_for_recipe(searched_for_country, response)
  end

  def create_poro_for_recipe(searched_for_country, response)
    response[:hits].map do |recipe|
      create_recipe_poro(searched_for_country, recipe)
    end
  end

  def create_recipe_poro(searched_for_country, recipe)
    Recipe.new({
      title: recipe[:recipe][:label],
      url: recipe[:recipe][:url],
      country: searched_for_country,
      image: recipe[:recipe][:image]
    })
  end
end