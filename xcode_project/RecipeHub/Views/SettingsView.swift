//
//  SettingsView.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/23/21.
//

import SwiftUI

struct SettingsView: View {

	@EnvironmentObject var settings: Settings

	let hosts = ["https://hackgt.rostersniper.com", "http://localhost:8000"]

	var body: some View {
		NavigationView {
			Form {
				Section {
					Picker("API Host", selection: $settings.api_host) {
						ForEach(hosts, id: \.self) {
							Text($0)
						}
					}
				}
			}
			.navigationTitle("Settings")
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
			.environmentObject(Settings())
    }
}

