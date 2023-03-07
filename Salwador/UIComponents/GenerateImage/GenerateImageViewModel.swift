//
//  IGViewModel.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 16.02.23.
//

import Foundation
import UIKit

@MainActor class GenerateImageViewModel: ObservableObject {
    @Published var buttonText: String = "Ready?"
    @Published var imagePath: String = "salvador-man"
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var errorMsg: String = ""
    @Published var isPopListShown: Bool = false

    let fileManager = FileManagerService()

    func sendRequest(prompText: String) async {
        do {
            handleViewState(state: requestState.loading, errMessage: "")

            let response = try await GenerateImageService.shared.generateImage(withPrompt: prompText, apiKey: fileManager.getApiKey())

            if let url = response.data.map(\.url).first {
                let (data, _) = try await URLSession.shared.data(from: url)

                image = UIImage(data: data)

                handleViewState(state: requestState.loaded, errMessage: "")
            }
        } catch FileManagerError.noAPIKeyFound {
            handleViewState(state: requestState.failed, errMessage: "No API Key was found, please try again!")
        } catch FileManagerError.invalidFilePath {
            handleViewState(state: requestState.failed, errMessage: "Invalid file path, please try again!")
        } catch FileManagerError.noFileFound {
            handleViewState(state: requestState.failed, errMessage: "No file was found, please try again!")
        } catch FileManagerError.failedReadingFileContent {
            handleViewState(state: requestState.failed, errMessage: "Failed to read file, please try again!")
        } catch ImageError.badURL {
            handleViewState(state: requestState.failed, errMessage: "URL is not valid, please try again!")
        } catch ImageError.emptyPrompt {
            handleViewState(state: requestState.failed, errMessage: "Prompt is empty, please enter some text and try again!")
        } catch {
            handleViewState(state: requestState.failed, errMessage: error.localizedDescription)
        }
    }

    enum requestState {
        case loading
        case loaded
        case failed
    }

    func handleViewState(state: requestState, errMessage: String) {
        switch state {
        case .loading:
            buttonText = "Loading..."
            hasError = false
            isLoading = true
            return

        case .loaded:
            buttonText = "Regenerate"
            hasError = false
            isLoading = false
            return

        case .failed:
            buttonText = "Retry"
            errorMsg = errMessage
            hasError = true
            isLoading = false
            return
        }
    }
}
