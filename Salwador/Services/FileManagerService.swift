//
//  FileManager.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 21.02.23.
//

import Foundation

class FileManagerService {
    func getFilePath(fileName: String, fileType: String) -> String? {
        Bundle.main.path(forResource: fileName, ofType: fileType)
    }

    func getFileURL(filePath: String) -> URL {
        URL(fileURLWithPath: filePath)
    }

    func readFile(fileName: String, fileType: String) throws -> Data? {
        guard let filepath = getFilePath(fileName: fileName, fileType: fileType) else {
            throw FileManagerError.noFileFound
        }

        let fileurl = getFileURL(filePath: filepath)

        do {
            let data = try Data(contentsOf: fileurl)
            return data
        } catch {
            throw FileManagerError.failedReadingFileContent
        }
    }

    func getApiKey() throws -> String {
        let data = try readFile(fileName: "APIKey", fileType: "json")
        var key = ""

        do {
            let json = try JSONDecoder().decode(APIJSONModel.self, from: data!)
            if let decodedData = Data(base64Encoded: json.apikey) {
                key = String(data: decodedData, encoding: .utf8)!
            }
        } catch {
            throw FileManagerError.noAPIKeyFound
        }
        return key
    }
}

enum FileManagerError: Error {
    case invalidFilePath
    case noFileFound
    case noAPIKeyFound
    case failedReadingFileContent
}
