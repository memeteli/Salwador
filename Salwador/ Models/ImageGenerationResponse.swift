// Created by Ailiniyazi Maimaiti on 31.01.23.

import Foundation

struct ImageGenerationResponse: Decodable {
    let created: Int
    let data: [ImageResponse]
}

struct ImageResponse: Codable {
    let url: URL
}

struct ImageGenerationRequest: Encodable {
    let promp, userID, imageSize: String
    let numberOfImage: Int

    enum CodingKeys: String, CodingKey {
        case promp
        case userID = "user"
        case imageSize = "size"
        case numberOfImage = "n"
    }
}
