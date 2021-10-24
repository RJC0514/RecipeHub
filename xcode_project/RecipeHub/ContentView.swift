//
//  ContentView.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import SwiftUI

struct ContentView: View {
	@StateObject var settings = Settings()
	@StateObject var favorites = Favorites()

	var body: some View {
		TabView {
			IngredientsView().tabItem {
				Image(systemName: "folder")
				Text("Ingredients")
			}

			Search().tabItem {
				Image(systemName: "magnifyingglass")
				Text("Search")
			}

			FavoritesView().tabItem {
				Image(systemName: "star.fill")
				Text("Favorites")
			}

			SettingsView().tabItem {
				Image(systemName: "gear")
				Text("Settings")
			}
		}
		.environmentObject(settings)
		.environmentObject(favorites)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
