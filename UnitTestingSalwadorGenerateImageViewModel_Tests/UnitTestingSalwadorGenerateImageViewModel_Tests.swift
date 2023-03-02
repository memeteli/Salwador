//
//  UnitTestingSalwadorGenerateImageViewModel_Tests.swift
//  UnitTestingSalwadorGenerateImageViewModel_Tests
//
//  Created by Ailiniyazi Maimaiti on 22.02.23.
//

import XCTest
@testable import Salwador

@MainActor class UnitTestingSalwadorGenerateImageViewModel_Tests: XCTestCase {
    private var vm: GenerateImageViewModel!
    private let samplePrompt = "Two programmers are fighting over which programming language is the best"

    @MainActor override func setUpWithError() throws {
        vm = GenerateImageViewModel()
    }

    override func tearDownWithError() throws {
//        vm = nil
    }

    func test_UnitTestingSalwadorGenerateImageViewModel_ShouldReturnErrorWithNoValidAPIKey() {
        vm.apiKeyFileName = "APIKey"
        Task {
            await vm.sendRequest(prompText: samplePrompt)
        }
        XCTAssertTrue(vm.hasError)
    }
}
