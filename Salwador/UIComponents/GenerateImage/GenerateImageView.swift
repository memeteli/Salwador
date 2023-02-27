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
    @State private var isPopL: String = ""
    @StateObject var viewModel = GenerateImageViewModel()
    @State var isPopListShown: Bool = false
    @State var generatedImage = UIImage()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                textEditorView
                submitButtonView
                Spacer()
                imageView
                Spacer()
            }
            .background(Color("BackgroundColor"))
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("Salwador")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color.pink,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateImageView()
    }
}

private extension GenerateImageView {
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
        .disabled(viewModel.isLoading)
        .frame(width: 150, height: 50)
        .foregroundColor(.white)
        .background(.pink)
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
                .foregroundColor(.white)
            Text("Your image is being generated...")
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
