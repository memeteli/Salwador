//
//  SamplePromptModel.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 23.02.23.
//

import Foundation

struct SamplePromptModel: Decodable {
    struct PromptText: Codable {
        var promptText: String
    }

    let demo: [PromptText]
}
