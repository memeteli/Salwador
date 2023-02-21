//
//  IGViewModel.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 16.02.23.
//

import Foundation
import UIKit

extension ContentView {
    @MainActor class IGViewModel: ObservableObject {
        @Published var buttonText: String = "Ready?"
        @Published var imagePath: String = "salvador-man"
        @Published var image: UIImage? = nil
        @Published var isLoading: Bool = false
        @Published var hasError: Bool = false
        @Published var errorMsg: String = ""

        func sendRequest(prompText: String) async {
            do {
                let response = try await ImageGenerator.shared.generateImage(withPrompt: prompText)

                if let url = response.data.map(\.url).first {
                    let (data, _) = try await URLSession.shared.data(from: url)

                    if data.isEmpty {
                        hasError = true
                        errorMsg = "No data was fetched, please retry again!"
                    }

                    image = UIImage(data: data)
                    isLoading = false
                    buttonText = "Regenerate"
                }
            } catch {
                hasError = true
                errorMsg = error.localizedDescription
                isLoading = false
                buttonText = "Regenerate"
                print(error)
            }
        }
    }
}
