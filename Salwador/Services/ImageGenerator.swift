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
    var apiKey = Credentials.apiKey

    private init() {}

    func generateImage(withPrompt prompt: String) async throws -> ImageGenerationResponse {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            throw ImageError.badURL
        }

        let requestBody = ImageGenerationRequest(prompt: prompt, userID: sessionID, imageSize: "1024x102", numberOfImage: 1)
        let data = try JSONEncoder().encode(requestBody)

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data

        print("22222", request)

        let (response, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ImageGenerationResponse.self, from: response)

        print("111111", result)

        return result
    }
}

enum ImageError: Error {
    case inValidPrompt, badURL
}
