class RecipeSerializer
  def serialized_json(all_recipes)
    {
      "data": all_recipes.map do |recipe|
        {
          "id": nil,
          "type": "recipe",
          "attributes": {
            "title": "#{recipe.title}",
            "url": "#{recipe.url}",
            "country": "#{recipe.country}",
            "image": "#{recipe.image}"
          }
        }
      end
    }
  end
end