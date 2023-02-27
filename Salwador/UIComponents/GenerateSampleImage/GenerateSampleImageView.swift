//
//  GenerateSampleImageView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 23.02.23.
//
import SwiftUI
import UIKit

struct GenerateSampleImageView: View {
    @StateObject var viewModel = GenerateImageViewModel()
    @State var isPopListShown: Bool = false
    @State var generatedImage = UIImage()
    let promptGenerator = SamplePromptGenerationService()

    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                Spacer()
                imageView
                Spacer()
            }

            if isPopListShown {
                ZStack {
                    PopList
                }
            }
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("Salwador")
        .toolbar {
            Button {
                viewModel.buttonText = "Wait..."
                viewModel.isLoading = true
                withAnimation {
                    isPopListShown = false
                }

                Task {
                    await viewModel.sendRequest(prompText: promptGenerator.getSamplePrompt())
                }
            } label: {
                Image(systemName: "shuffle")
            }
            .disabled(viewModel.isLoading)
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
                await viewModel.sendRequest(prompText: promptGenerator.getSamplePrompt())
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
                        .onLongPressGesture(minimumDuration: 0.5) {
                            print("Long pressed!")
                            withAnimation {
                                generatedImage = identifier
                                isPopListShown = true
                            }
                        }
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

            Text("Sample image is being generated...")
                .font(.title3)
                .foregroundColor(Color("TextColor"))
        }
    }

    var PopList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                UIImageWriteToSavedPhotosAlbum(generatedImage, nil, nil, nil)
                                isPopListShown = false
                            }
                        }
                    label: {
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .frame(width: 22, height: 25)
                                .foregroundColor(.white)
                            Text("Save")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.leading)

                    Divider()

                    HStack {
                        let photo = Photo(image: Image(uiImage: generatedImage))

                        ShareLink(
                            item: photo.image,
                            preview: SharePreview(
                                "Hey, check it out! I've created an AI-Image via Salwador App...",
                                image: photo.image
                            )
                        ) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable().frame(width: 22, height: 25).foregroundColor(.white)

                                Text("Share")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .labelStyle(.titleAndIcon)
                        .imageScale(.large)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading)
                }
                .padding(10)
                .background(.pink)
                .cornerRadius(10)

                ZStack {
                    Button {
                        withAnimation {
                            isPopListShown = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.pink)
                                .padding(10)
                        }
                    }
                }
                .background(.white)
                .clipShape(Circle())
            }
        }
        .padding(.top)
        .frame(width: 200, height: 190)
    }
}
