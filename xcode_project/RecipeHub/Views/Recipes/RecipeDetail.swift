//
//  RecipeDetail.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import SwiftUI

struct RecipeDetail: View {
	@EnvironmentObject var favorites: Favorites
	var recipe: Recipe
	var isFav: Bool {
		!favorites.recipes.filter({ $0.name == recipe.name }).isEmpty
	}

    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				AsyncImage(url: URL(string: recipe.image_url)) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(maxHeight: 200)
						.clipped()
						.cornerRadius(10)
				} placeholder: {
					ProgressView()
				}
				Text("Ingredients")
					.font(.title2)
				ForEach(recipe.ingredients, id: \.self) { i in
					Text("• \(i)")
				}

				Divider()

				Text("Instructions")
					.font(.title2)
				Text(recipe.instructions)
			}
			.padding()
		}
		.navigationTitle(recipe.name)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(isFav ? "Unfavorite" : "Favorite") {
					if isFav {
						favorites.recipes = favorites.recipes.filter({ $0.name != recipe.name })
					} else {
						favorites.add(recipe)
					}
				}
			}
		}
	}
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
		RecipeDetail(recipe: ModelData().recipe)
    }
}
