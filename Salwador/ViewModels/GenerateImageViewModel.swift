//
//  IGViewModel.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 16.02.23.
//

import Foundation
import UIKit

extension GenerateImageView {
    @MainActor class GenerateImageViewModel: ObservableObject {
        @Published var buttonText: String = "Ready?"
        @Published var imagePath: String = "salvador-man"
        @Published var image: UIImage? = nil
        @Published var isLoading: Bool = false
        @Published var hasError: Bool = false
        @Published var errorMsg: String = ""

        func sendRequest(prompText: String) async {
            let fileManager = FileManagerService()

            let data = fileManager.readFile(fileName: "APIKey", fileType: "json")

            do {
                let json = try JSONDecoder().decode(APIJSONModel.self, from: data!)
                let response = try await GenerateImageService.shared.generateImage(withPrompt: prompText, apiKey: json.apikey)

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
