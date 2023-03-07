// Created by Ailiniyazi Maimaiti on 31.01.23.
import Foundation

struct ImageGenerationResponsePayload: Decodable {
    struct ImageResponsePayload: Codable {
        let url: URL
    }

    let created: Int
    let data: [ImageResponsePayload]
}
