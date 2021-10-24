//
//  Recipe.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import Foundation

struct Recipe: Codable {
	var name: String
	var image_url: String

	var ingredients: [String]
	var instructions: String
}
