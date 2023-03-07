// Created by Ailiniyazi Maimaiti on 31.01.23.
import Foundation

struct ImageGenerationRequestPayload: Encodable {
    let prompt: String
    let userID: String
    let imageSize: String
    let numberOfImage: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user"
        case imageSize = "size"
        case numberOfImage = "n"
        case prompt
    }
}
