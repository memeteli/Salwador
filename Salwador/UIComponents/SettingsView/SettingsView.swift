//
//  SettingsView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 07.03.23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    @Binding var systemSchemaEnabled: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $darkModeEnabled) {
                        Text("Dark Mode:")
                    }
                    .onChange(of: darkModeEnabled, perform: { _ in
                        ThemeManager.shared.handleTheme(darkMode: darkModeEnabled, systemSchema: systemSchemaEnabled)

                    })

                    Toggle(isOn: $systemSchemaEnabled) {
                        Text("Use System Schema:")
                    }
                    .onChange(of: systemSchemaEnabled, perform: { _ in
                        ThemeManager.shared.handleTheme(darkMode: darkModeEnabled, systemSchema: systemSchemaEnabled)

                    })
                }

                Section {
                    HStack {
                        Image(systemName: "link")
                        Link("Find me on Github", destination: URL(string: "https://github.com/memeteli/Salwador")!)
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemSchemaEnabled: .constant(false))
    }
}
