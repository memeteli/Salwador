//
//  ThemeManager.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 07.03.23.
//

import Foundation
import UIKit

class ThemeManager {
    static let shared = ThemeManager()

    private init() {}

    func handleTheme(darkMode: Bool, systemSchema: Bool) {
        guard !systemSchema else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
            return
        }

        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
}
