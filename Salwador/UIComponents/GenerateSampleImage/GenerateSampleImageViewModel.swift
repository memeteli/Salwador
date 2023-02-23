//
//  GenerateSampleImageViewModel.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 23.02.23.
//
import Foundation
import UIKit

@MainActor class GenerateSampleImageViewModel: ObservableObject {
    @Published var imagePath: String = "salvador-man"
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var errorMsg: String = ""
    @Published var apiKeyFileName: String = ""

    let fileManager = FileManagerService()

    func sendRequest(prompText _: String) async {
        do {
            let api_data = fileManager.readFile(fileName: apiKeyFileName, fileType: "json")
            let data = fileManager.readFile(fileName: "Prompts", fileType: "json")

            let api_json = try JSONDecoder().decode(APIJSONModel.self, from: api_data!)
            let json = try JSONDecoder().decode(SamplePromptModel.self, from: data!)
            let prompTextsArray: Array = json.demo
            let random_index = Int(arc4random_uniform(UInt32(prompTextsArray.count)))

            let response = try await GenerateImageService.shared.generateImage(withPrompt: prompTextsArray[random_index].promptText, apiKey: api_json.apikey)
            if let url = response.data.map(\.url).first {
                let (data, _) = try await URLSession.shared.data(from: url)

                if data.isEmpty {
                    hasError = true
                    errorMsg = "No data was fetched, please retry again!"
                }

                image = UIImage(data: data)
                isLoading = false
            }
        } catch {
            hasError = true
            errorMsg = error.localizedDescription

            isLoading = false
        }
    }
}
