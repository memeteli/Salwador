//
//  UnitTestingSalwadorFilemanager_Tests.swift
//  UnitTestingSalwadorFilemanager_Tests
//
//  Created by Ailiniyazi Maimaiti on 22.02.23.
//

import XCTest

final class UnitTestingSalwadorFilemanager_Tests: XCTestCase {
    // Configurations
    private let fileName = "APIKey.json"
    private let fm = FileManagerService()

    let valid_filepath = FileManagerService().getFilePath(fileName: "APIKey", fileType: "json")
    let not_valid_filepath = FileManagerService().getFilePath(fileName: "NoExistingJSONFile", fileType: "json")

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_UnitTestingSalwadorFilemanagerSevice_getFilePath_ValidFilePath_shouldReturnValidFilePath() {
        XCTAssertNotNil(valid_filepath)
        XCTAssertNotEqual(valid_filepath, "")
        XCTAssertTrue(valid_filepath.contains("Salwador.app/APIKey.json"))
    }

    func test_UnitTestingSalwadorFileManagerService_getFilePath_NotValidFilePath_shouldReturnEmptyString() {
        XCTAssertEqual(not_valid_filepath, "")
        XCTAssertFalse(not_valid_filepath.contains(fileName))
    }

    func test_UnitTestingSalwadorFileManagerService_getFileURL_ValidFilePath_shouldReturnValidFileURL() {
        let fileURL = fm.getFileURL(filePath: valid_filepath)
        XCTAssertTrue(type(of: fileURL) == URL.self)
        XCTAssertTrue(fileURL.pathComponents.contains(fileName))
    }

    func test_UnitTestingSalwadorFileManagerService_getFileURL_NotValidFilePath_shouldReturnError() {
        let fileURL = fm.getFileURL(filePath: not_valid_filepath)
        XCTAssertTrue(type(of: fileURL) == URL.self)
        XCTAssertFalse(fileURL.pathComponents.contains(fileName))
    }

    func test_UnitTestingSalwadorFileManagerService_readFile_ValidFilePath_shouldReturnNil() {
        let data = fm.readFile(fileName: "APIKey", fileType: "json")
        XCTAssertNotEqual(data, nil)
        XCTAssertFalse(data!.isEmpty)
    }

    func test_UnitTestingSalwadorFileManagerService_readFile_NotValidFilePath_shouldReturnNil() {
        let data = fm.readFile(fileName: "NoExistingJSONFile", fileType: "json")
        XCTAssertEqual(data, nil)
    }
}
