//
//  Search.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import SwiftUI

struct Search: View {

	@EnvironmentObject var settings: Settings

	@State private var searchText = ""
	@State private var recipes = [Recipe]()

	var body: some View {
		NavigationView {
			RecipesBlock(recipes: $recipes)
			.navigationTitle("Find Recipes")
			.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
			.onSubmit(of: .search) {
				getRecipes()
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}

	private func getRecipes() {
		var url = URLComponents(string: "\(settings.api_host)/api/search_recipes")!
		url.queryItems = [
			URLQueryItem(
				name: "name",
				value: searchText
			)
		]

		URLSession.shared.dataTask(with: url.url!) {
			data, _, _ in

			guard
				let data = data,
				let recipes = try? JSONDecoder().decode([Recipe].self, from: data)
			else {
				DispatchQueue.main.async {
					recipes.removeAll()
					print("Error searching for recipes")
				}
				return
			}

			self.recipes = recipes
		}.resume()
	}
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
