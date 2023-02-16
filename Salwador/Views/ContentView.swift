//
//  ContentView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 31.01.23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var prompText: String = ""
    @State private var buttonText: String = "Ready?"
    @State private var imagePath: String = "salvador-man"
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = false
    @State private var hasError: Bool = false
    @State private var errorMsg: String = ""

    var body: some View {
        ZStack {
            VStack {
                appNameView
                Spacer()
                textEditorView
                submitButtonView
                    .padding(10)
                Spacer()
                imageView
                Spacer()
            }
        }
        .background(Color("Colors/Background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    var appNameView: some View {
        VStack {
            Text("Salvador")
                .foregroundColor(ColorPalette.grayColor)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)

            Image("salvador-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)

            Text("Your AI Image Generator")
                .foregroundColor(ColorPalette.grayColor)
                .font(.footnote)
        }
    }

    var textEditorView: some View {
        ZStack {
            TextEditor(
                text: $prompText)
                .font(.title2)
                .frame(minWidth: 320, idealWidth: 500, maxWidth: .infinity, minHeight: 100, idealHeight: 200, maxHeight: .infinity)
                .scaledToFit()
                .border(Color(.black), width: 1)
                .padding(10)
                .cornerRadius(10)
        }
        .background(ColorPalette.grayDarkColor)
    }

    var submitButtonView: some View {
        Button(buttonText) {
            buttonText = "Wait..."
            isLoading = true
            sendRequest(prompText: prompText)
        }
        .frame(width: 150, height: 50)
        .foregroundColor(ColorPalette.grayColor)
        .background(ColorPalette.mainOrangeColor)
        .cornerRadius(10)
    }

    var imageView: some View {
        VStack {
            if hasError {
                HStack {
                    Image(systemName: "bell")
                        .foregroundColor(.red)
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    Text(errorMsg)
                        .foregroundColor(ColorPalette.grayColor)
                }
            } else if let image {
                if isLoading {
                    loadingView
                }

                if !isLoading {
                    Image(uiImage: image)
                        .resizable()
                        .foregroundColor(Color.red)
                        .scaledToFit()
                        .frame(width: 440, height: 320)
                }

            } else {
                if isLoading {
                    loadingView
                }
            }
        }
    }

    var loadingView: some View {
        VStack {
            ProgressView()
                .background(ColorPalette.grayColor)
                .foregroundColor(ColorPalette.grayColor)
            Text("Your image is generating...")
                .font(.title3)
                .foregroundColor(ColorPalette.grayColor)
        }
    }

    private func sendRequest(prompText: String) {
        Task {
            do {
                let response = try await ImageGenerator.shared.generateImage(withPrompt: prompText, apiKey: Credentials.apiKey)

                if let url = response.data.map(\.url).first {
                    let (data, _) = try await URLSession.shared.data(from: url)

                    if data.isEmpty {
                        hasError = true
                        errorMsg = "No data was fetched, please retry again!"
                    }

                    image = UIImage(data: data)
                    isLoading = false
                    buttonText = "Regenerate"
                }
            } catch {
                hasError = true
                errorMsg = error.localizedDescription
                isLoading = false
                buttonText = "Regenerate"
            }
        }
    }
}
