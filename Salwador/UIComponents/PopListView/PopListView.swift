//
//  PopListView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 27.02.23.
//

import SwiftUI

extension GenerateImageView {
    var PopList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                UIImageWriteToSavedPhotosAlbum(generatedImage, nil, nil, nil)
                                viewModel.isPopListShown = false
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
                .background(Color("OrangeColor")
                )
                .cornerRadius(10)

                ZStack {
                    Button {
                        withAnimation {
                            viewModel.isPopListShown = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color("OrangeColor")
                                )
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
