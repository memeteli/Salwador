//
//  GenerateSampleImageView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 23.02.23.
//
import SwiftUI
import UIKit

struct GenerateSampleImageView: View {
    @StateObject var viewModel = GenerateSampleImageViewModel()

    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                Spacer()
                imageView
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("Salwador")
        .toolbar {
            Button {
                viewModel.buttonText = "Wait..."
                viewModel.isLoading = true
                viewModel.apiKeyFileName = "APIKey"

                Task {
                    await viewModel.sendRequest()
                }
            } label: {
                Image(systemName: "shuffle")
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color.pink,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            viewModel.isLoading = true
            Task {
                await viewModel.sendRequest()
            }
        }
    }
}

struct GenerateSampleImageView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateSampleImageView()
    }
}

private extension GenerateSampleImageView {
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
                        .frame(width: 440, height: 440)
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
                .foregroundColor(.white)

            Text("Your image is generating...")
                .font(.title3)
                .foregroundColor(Color("TextColor"))
        }
    }
}
