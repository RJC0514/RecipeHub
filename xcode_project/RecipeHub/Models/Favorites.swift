//
//  Favorites.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import Foundation

final class Favorites: ObservableObject {
	@Published var recipes = [Recipe]()
	// = Bundle.main.decode([Recipe].self, from: "recipes.json")

	func add(_ recipe: Recipe) {
		recipes.append(recipe)
	}
}
