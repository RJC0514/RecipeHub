//
//  IngredientsView.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import SwiftUI

class IngredientList: ObservableObject {
	@Published var list = [String]()
}

struct IngredientsView: View {

	@EnvironmentObject var settings: Settings
	@EnvironmentObject var favorites: Favorites

	@State private var editMode = EditMode.inactive

	@FocusState private var isInsertingFocused: Bool
	@State private var isInserting = false
	@State private var insertText = ""

	@State private var showingRecognizer = false

	@State private var showingRecipeps = false
	@State private var resultRecipes = [Recipe]()

	@State private var alertMsg = ""
	@State private var showAlert = false

	@State private var ingredients = [String]()
	func addIngredient(_ ingredient: String) {
		ingredients.append(ingredient)
	}
	func hasIngredient(_ ingredient: String) -> Bool {
		return ingredients.contains(ingredient)
	}

	// "Presenting view controller (alert) from detached view controller is discouraged"
	var body: some View {
		NavigationView {
			List {
				Section {
					NavigationLink(
						"Get Recipes",
						destination:
							RecipesBlock(recipes: $resultRecipes)
								.onAppear() { getRecipes() },
						isActive: $showingRecipeps
					)
						.disabled(ingredients.isEmpty)
				}
				Section(header: Text("Ingredients")) {
					if ingredients.isEmpty && !isInserting {
						Text("Tap the camera to add ingredients")
					} else {
						ForEach(ingredients, id: \.self) { ing in
							Text(ing)
						}
						.onDelete { ingredients.remove(atOffsets: $0) }
					}
					if isInserting {
						TextField("Add Ingredient", text: $insertText)
							.focused($isInsertingFocused)
							.submitLabel(.done)
							.onSubmit {
								isInserting = false
								if !insertText.isEmpty {
									ingredients.append(insertText.capitalized)
									insertText = ""
								}
							}
					}

				}
			}
			.navigationTitle("Recipe Finder")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					if editMode.isEditing {
						Button("Clear") {
							ingredients.removeAll()
							editMode = .inactive
						}
					} else {
						Button {
							isInserting = true
							// wtf
							DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
								isInsertingFocused = true
							}
						} label: {
							Image(systemName: "keyboard")
						}
						Button(
							action: { showingRecognizer.toggle() },
							label: { Image(systemName: "camera") }
						)
						.sheet(isPresented: $showingRecognizer) {
							RecognizerView(addIngredient(_:), hasIngredient(_:))
						}
					}
				}
			}
			.environment(\.editMode, $editMode)
			.alert(alertMsg, isPresented: $showAlert) {
				Button("OK", role: .cancel) { showingRecipeps = false }
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}

	private func getRecipes() {
		var url = URLComponents(string: "\(settings.api_host)/api/get_recipes")!
		url.queryItems = [
			URLQueryItem(
				name: "ingredients",
				value: ingredients.joined(separator: "_")
			)
		]

		URLSession.shared.dataTask(with: url.url!) {
			data, _, _ in

			guard let data = data else {
				DispatchQueue.main.async {
					alertMsg = "Error downloading recipeps"
					showAlert = true
				}
				return
			}

			guard let recipes = try? JSONDecoder().decode([Recipe].self, from: data)
			else {
				alertMsg = "Error decoding recipeps"
				showAlert = true
				return
			}
			self.resultRecipes = recipes

		}.resume()
	}
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
