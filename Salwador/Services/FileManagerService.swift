//
//  FileManager.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 21.02.23.
//

import Foundation

class FileManagerService {
    func getFilePath(fileName: String, fileType: String) -> String {
        Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
    }

    func getFileURL(filePath: String) -> URL {
        URL(fileURLWithPath: filePath)
    }

    func readFile(filename: String, filetype: String) -> Data? {
        let filepath = getFilePath(fileName: filename, fileType: filetype)
        let fileurl = getFileURL(filePath: filepath)

        do {
            let data = try Data(contentsOf: fileurl)
            return data
        } catch {
            print(error)
        }

        return nil
    }

    func writeFile(data _: Data, filepath _: String) {}
    // TODO: create write file function as well in the future
}
