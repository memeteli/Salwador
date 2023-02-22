// Created by Ailiniyazi Maimaiti on 31.01.23.
import Foundation

struct ImageGenerationResponse: Decodable {
    struct ImageResponse: Codable {
        let url: URL
    }

    let created: Int
    let data: [ImageResponse]
}
