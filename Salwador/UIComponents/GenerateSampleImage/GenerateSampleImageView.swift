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
    @State var isPopListShown: Bool = false
    @State var imageIdentifier = UIImage()

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
                viewModel.apiKeyFileName = "APIKey"
                withAnimation {
                    isPopListShown = false
                }

                Task {
                    await viewModel.sendRequest()
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
                        .onLongPressGesture(minimumDuration: 0.5) {
                            print("Long pressed!")
                            withAnimation {
                                imageIdentifier = identifier
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

            Text("Sample image is generating...")
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
                                UIImageWriteToSavedPhotosAlbum(imageIdentifier, nil, nil, nil)
                                isPopListShown = false
                            }
                        }
                    label: {
                            Image(systemName: "arrow.down.app")
                                .resizable()
                                .frame(width: 25, height: 25)
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
                        Button {
                            // TODO: here is for logic for sharing code
                            print("Image is being shared....")
                            isPopListShown = false
                        }
                    label: {
                            Image(systemName: "arrow.up.square")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                            Text("Share")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
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
                            isPopListShown = true
                        }
                        print("isPopListShown", isPopListShown)
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
