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
    
    private init () {
        
    }

    func isPrompValid (_ prompt: String, apiKey: String) async throws -> Bool {
        guard let url = URL(string: "https://api.openai.com/v1/moderations") else {
            return false;
        }

        let params:[String: Any] = [
            "input" : prompt
        ]
        let data: Data = try JSONSerialization.data(withJSONObject: params)

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data

        let (response, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ModerationResponse.self, from: response)

        return result.hasIssues == false
    }

    func generateImage(withPrompt prompt: String, apiKey: String) async throws -> ImageGenerationResponse {
        guard try await isPrompValid(prompt, apiKey: apiKey) else {
            throw ImageError.inValidPrompt
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            throw ImageError.badURL
        }

        let params: [String: Any] = [
            "prompt" : prompt,
            "n" : 1,
            "size" : "1024x1024",
            "user": sessionID
        ]

        let data: Data = try JSONSerialization.data(withJSONObject: params)

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
