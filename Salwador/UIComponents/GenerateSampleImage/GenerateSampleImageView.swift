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
    @State var show: Bool = false

    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                Spacer()
                if self.show {
                    GeometryReader {
                        _ in
                        VStack {
                            PopList
                        }
                        .background(Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all))
                    }
                }

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
                        .onLongPressGesture(minimumDuration: 1) {
                            print("Long pressed!")
                            self.show.toggle()
                        }
                    Button {
                        UIImageWriteToSavedPhotosAlbum(identifier, nil, nil, nil)
                    } label: {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("Save to Photos")
                        }
                        .font(.title2)
                        .foregroundColor(.pink)
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
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.leading)

                    Divider()

                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Text("Share")
                            .fontWeight(.bold)
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
                            self.show.toggle()
                        }
                        print("show", self.show)
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                                .padding(10)
                        }
                    }
                }
                .background(.black)
                .clipShape(Circle())
            }
        }
        .padding(.top)
        .frame(width: 200, height: 190)
    }
}
