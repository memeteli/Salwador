//
//  SamplePromptGenerationService.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 27.02.23.
//

import Foundation

class SamplePromptGenerationService {
    func getSamplePrompt() -> String {
        let fileManager = FileManagerService()
        let data = fileManager.readFile(fileName: "Prompts", fileType: "json")

        do {
            let json = try JSONDecoder().decode(SamplePromptModel.self, from: data!)
            let prompTextsArray: Array = json.demo
            let random_index = Int(arc4random_uniform(UInt32(prompTextsArray.count)))

            return prompTextsArray[random_index].promptText
        } catch {
            return error.localizedDescription
        }
    }
}
