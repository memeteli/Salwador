//
//  ImageGenerator.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 07.02.23.
//

import SwiftUI

class ImageGenerator {
    static let shared = ImageGenerator()
    let sessionID = UUID().uuidString

    private init() {}

    func generateImage(withPrompt prompt: String, apiKey: String) async throws -> ImageGenerationResponse {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            throw ImageError.badURL
        }

        let requestBody = ImageGenerationRequest(promp: prompt, userID: sessionID, imageSize: "1024x102", numberOfImage: 1)
        let data = try JSONEncoder().encode(requestBody)

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data

        let (response, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ImageGenerationResponse.self, from: response)

        return result
    }
}

enum ImageError: Error {
    case inValidPrompt, badURL
}
