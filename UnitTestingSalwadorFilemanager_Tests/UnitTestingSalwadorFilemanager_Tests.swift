//
//  UnitTestingSalwadorFilemanager_Tests.swift
//  UnitTestingSalwadorFilemanager_Tests
//
//  Created by Ailiniyazi Maimaiti on 22.02.23.
//

import XCTest

final class UnitTestingSalwadorFilemanager_Tests: XCTestCase {
    private let fm = FileManagerService()
    private let sampleFilePath = "/Users/uyghurbeg/Library/Developer/XCTestDevices/5D2C42E5-A987-46EC-990C-DA36DFF150EB/data/Containers/Bundle/Application/C8AC0B93-B121-4A31-9DBC-0560FFA546E1/Salwador.app/APIKey.json"

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_UnitTestingSalwadorFilemanagerSevice_getFilePath_shouldReturnValidFilePath() {
        let filepath = fm.getFilePath(fileName: "APIKey", fileType: "json")
        XCTAssertEqual(filepath, sampleFilePath)
    }

    func test_UnitTestingSalwadorFileManagerService_getFilePath_shouldReturnEmptyString() {
        let filepath = fm.getFilePath(fileName: "APIKey", fileType: "json")
        XCTAssertNotEqual(filepath, sampleFilePath)
    }
}
