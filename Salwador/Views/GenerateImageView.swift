//
//  ContentView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 31.01.23.
//

import SwiftUI
import UIKit

struct GenerateImageView: View {
    @State private var prompText: String = ""
    @StateObject var viewModel = GenerateImageViewModel()

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
        .background(Color("BackgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                        GenerateImageView()
    }
}

private extension GenerateImageView {
    var appNameView: some View {
        VStack {
            Text("Salvador")
                .foregroundColor(Color("TextColor"))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)

            Image("salvador-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)

            Text("Your AI Image Generator")
                .foregroundColor(Color("TextColor"))
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
        .background(Color("BackgroundColor"))
    }

    var submitButtonView: some View {
        Button(viewModel.buttonText) {
            viewModel.buttonText = "Wait..."
            viewModel.isLoading = true
            Task {
                await viewModel.sendRequest(prompText: prompText)
            }
        }
        .frame(width: 150, height: 50)
        .foregroundColor(Color("TextColor"))
        .background(Color("OrangeColor"))
        .cornerRadius(10)
    }

    var imageView: some View {
        VStack {
            if viewModel.hasError {
                HStack {
                    Image(systemName: "bell")
                        .foregroundColor(.red)
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    Text(viewModel.errorMsg)
                        .foregroundColor(Color("TextColor"))
                }
            } else if let identifier = viewModel.image {
                if viewModel.isLoading {
                    loadingView
                }

                if !viewModel.isLoading {
                    Image(uiImage: identifier)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 440, height: 320)
                }

            } else {
                if viewModel.isLoading {
                    loadingView
                }
            }
        }
    }

    var loadingView: some View {
        VStack {
            ProgressView()
                .background(Color("TextColor"))
                .foregroundColor(Color("TextColor"))
            Text("Your image is generating...")
                .font(.title3)
                .foregroundColor(Color("TextColor"))
        }
    }
}
