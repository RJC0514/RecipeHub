//
//  RecipesBlock.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import SwiftUI

struct RecipesBlock: View {
	@Binding var recipes: [Recipe]

	var body: some View {
		List {
			ForEach(recipes, id: \.name) { recipe in
				NavigationLink(destination: RecipeDetail(recipe: recipe)) {
					HStack {
						AsyncImage(url: URL(string: recipe.image_url)) { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 40, height: 40)
								.clipped()
								.cornerRadius(10)
						} placeholder: {
							ProgressView()
						}
						Text(recipe.name)
					}
				}
			}

		}
		.navigationTitle("Recipes")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct RecipeBlock_Previews: PreviewProvider {
	static let modelData = ModelData()
    static var previews: some View {
		RecipesBlock(recipes: Binding(
			get: { modelData.recipes },
			set: { _ in }
		))
    }
}
