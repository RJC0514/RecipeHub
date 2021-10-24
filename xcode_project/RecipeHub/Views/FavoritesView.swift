//
//  FavoritesView.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import SwiftUI

struct FavoritesView: View {
	@EnvironmentObject var favorites: Favorites
	@State private var editMode = EditMode.inactive

	var body: some View {
		NavigationView {
			List {
				if favorites.recipes.isEmpty {
					Text("You don't have any favorites 😢")
				}
				ForEach(favorites.recipes, id: \.name) { recipe in
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
				.onMove {
					favorites.recipes.move(fromOffsets: $0, toOffset: $1)
				}
				.onDelete {
					favorites.recipes.remove(atOffsets: $0)
				}
			}
			.navigationTitle("Favorites")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
						.disabled(favorites.recipes.isEmpty)
				}
				ToolbarItem(placement: .navigationBarLeading) {
					if editMode.isEditing {
						Button("Clear") {
							favorites.recipes.removeAll()
							editMode = .inactive
						}
					}
				}
			}
			.environment(\.editMode, $editMode)
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
		FavoritesView()
			.environmentObject(Favorites())
    }
}
