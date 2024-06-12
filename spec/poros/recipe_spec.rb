require 'rails_helper'

RSpec.describe Recipe do
  it 'exists and can initialize' do
    recipe = Recipe.new({
      title: 'Delicious Burger Recipe',
      url: 'https://www.recipes.com/recipes/123',
      country: 'United States',
      image: 'https://www.recipes.com/recipes/123/images/1'
    })

    expect(recipe).to be_a Recipe
    expect(recipe.title).to eq('Delicious Burger Recipe')
    expect(recipe.url).to eq('https://www.recipes.com/recipes/123')
    expect(recipe.country).to eq('United States')
    expect(recipe.image).to eq('https://www.recipes.com/recipes/123/images/1')
  end
end