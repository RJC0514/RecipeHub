//
//  ModelData.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import Foundation

final class ModelData: ObservableObject {

	var recipes = Bundle.main.decode([Recipe].self, from: "recipes.json")
	var recipe: Recipe

	init() {
		recipe = recipes[0]
	}
}

extension Bundle {
	func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil)
		else {
			fatalError("Failed to locate \(file) in bundle.")
		}

		guard let data = try? Data(contentsOf: url)
		else {
			fatalError("Failed to load \(file) from bundle.")
		}

		guard let loaded = try? JSONDecoder().decode(type, from: data)
		else {
			fatalError("Failed to decode \(file) from bundle.")
		}

		return loaded
	}
}
