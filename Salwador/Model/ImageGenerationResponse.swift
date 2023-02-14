// Created by Ailiniyazi Maimaiti on 31.01.23.

import Foundation

struct ImageGenerationResponse: Encodable {
    struct ImageResponse: Encodable {
        let url: URL
    }

    let created: Int
    let data: [ImageResponse]
}
