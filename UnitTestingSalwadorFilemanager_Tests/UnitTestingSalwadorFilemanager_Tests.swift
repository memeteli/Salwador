//
//  UnitTestingSalwadorFilemanager_Tests.swift
//  UnitTestingSalwadorFilemanager_Tests
//
//  Created by Ailiniyazi Maimaiti on 22.02.23.
//

import XCTest

final class UnitTestingSalwadorFilemanager_Tests: XCTestCase {
    //Configurations
    private let fileName = "APIKey.json"
    private let fm = FileManagerService()
    
    let valid_filepath = FileManagerService().getFilePath(fileName: "APIKey", fileType: "json")
    let not_valid_filepath = FileManagerService().getFilePath(fileName: "NoExistingJSONFile", fileType: "json")
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    func test_UnitTestingSalwadorFilemanagerSevice_getFilePath_shouldReturnValidFilePath() {
        XCTAssertNotNil(valid_filepath)
        XCTAssertNotEqual(valid_filepath, "")
        XCTAssertTrue(valid_filepath.contains("Salwador.app/APIKey.json"))
    }
    
    func test_UnitTestingSalwadorFileManagerService_getFilePath_shouldReturnEmptyString() {
        XCTAssertEqual(not_valid_filepath, "")
        XCTAssertFalse(not_valid_filepath.contains(fileName))
    }
    
    func test_UnitTestingSalwadorFileManagerService_getFileURL_shouldReturnValidFileURL() {
        let
    }
}
