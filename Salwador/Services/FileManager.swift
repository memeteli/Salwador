//
//  FileManager.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 21.02.23.
//

import Foundation

class FileManager {
    let filename, filetype: String
    let apikey:String
    
    init(filename: String, filetype: String) {
        self.filename = filename
        self.filetype = filetype
    }

    func getFilePath(fileName: String, fileType: String) -> String {
        Bundle.main.path(forResource: fileName, ofType: fileType) ?? "error"
    }

    func getFileURL(filePath: String) -> URL {
        URL(fileURLWithPath: filePath)
    }

    func readFile() -> AnyObject {
        let filepath = getFilePath(fileName: filename, fileType: filetype)
        let fileurl = getFileURL(filePath: filepath)
        var data:Data = Data()

        do {
            data = try Data(contentsOf: fileurl)
            let jsonDecoder = JSONDecoder()

            if filetype == "json" {
               return try jsonDecoder.decode(APIJSONModel.self, from: data)
            }
        } catch {
            print(error)
        }
        
        return data
    }

    func writeFile(data _: Data) {}
    // TODO: create write file function as well in the future
}
