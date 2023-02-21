//
//  FileManager.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 21.02.23.
//

import Foundation

class FileManager {
    let filename, filetype:String
    
    init(filename: String, filetype: String) {
        self.filename = filename
        self.filetype = filetype
    }
    
    func getFilePath(fileName:String, fileType:String) -> String? {
        return Bundle.main.path(forResource: fileName, ofType: fileType)
    }
    
    func getFileURL(filePath:String) -> URL? {
        return URL(fileURLWithPath: filePath)
    }
    
    func getFileData(fileURL: URL) -> Data? {
        do {
           return try Data(contentsOf: fileURL)
         } catch {
             return Data(error.localizedDescription.utf8)
         }
    }
    
    func readFile() {
        let filepath = getFilePath(fileName: filename, fileType: filetype )
        let fileurl = getFileURL(filePath: filepath!)
        let data = getFileData(fileURL: fileurl!)
        
        if(self.filetype == "json") {
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let apikey = json["apikey"] as? [String] {
                        print(apikey)
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    //TODO: create write file function as well in the future
    
}
