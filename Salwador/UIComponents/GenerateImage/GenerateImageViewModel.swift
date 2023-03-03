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
            handleViewState(state: requestState.loading)

            let response = try await GenerateImageService.shared.generateImage(withPrompt: prompText, apiKey: fileManager.getApiKey())

            if let url = response.data.map(\.url).first {
                let (data, _) = try await URLSession.shared.data(from: url)

                image = UIImage(data: data)

                handleViewState(state: requestState.loaded)
            }
        } catch {
            handleViewState(state: requestState.failed)
        }
    }

    enum requestState {
        case loading
        case loaded
        case failed
    }

    func handleViewState(state: requestState) {
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
            errorMsg = "No data was fetched, please retry again!"
            hasError = true
            isLoading = false
            return
        }
    }
}
