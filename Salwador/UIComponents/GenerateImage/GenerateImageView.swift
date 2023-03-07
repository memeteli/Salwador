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
    @State var generatedImage = UIImage()
    @State private var showingPopover = false

    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                Spacer()
                textEditorView
                submitButtonView
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("Salwador")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("OrangeColor"),
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
            TextField("Enter your prompt...", text: $prompText).font(.title2)
                .frame(width: 320, height: 40)
                .border(Color("OrangeColor"), width: 1)
                .padding(20)
                .cornerRadius(10)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.default)
        }
    }

    var submitButtonView: some View {
        Button(viewModel.buttonText) {
            viewModel.buttonText = "Wait..."
            viewModel.isLoading = true
            showingPopover = true

            withAnimation {
                viewModel.isPopListShown = false
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }

            Task {
                await viewModel.sendRequest(prompText: prompText)
            }
        }
        .disabled(viewModel.isLoading)
        .frame(width: 150, height: 50)
        .foregroundColor(.white)
        .background(Color("OrangeColor"))
        .cornerRadius(10)
        .popover(isPresented: $showingPopover) {
            imageView
        }
    }

    var closeButton: some View {
        ZStack {
            Button {
                withAnimation {
                    showingPopover = false
                    viewModel.isPopListShown = false
                }
            } label: {
                HStack {
                    Image(systemName: "arrowtriangle.down")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("TextColor"))
                        .padding(10)
                }
            }
        }
    }

    var popListView: some View {
        ZStack(alignment: .bottom) {
            PopList
        }
    }

    var imageView: some View {
        VStack {
            if viewModel.hasError {
                Spacer()

                HStack {
                    Image(systemName: "bell")
                        .foregroundColor(.red)
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    Text(viewModel.errorMsg)
                        .foregroundColor(Color("TextColor"))
                }

                Spacer()

                closeButton
            } else if let identifier = viewModel.image {
                if viewModel.isLoading {
                    loadingView
                }

                if !viewModel.isLoading {
                    Spacer()

                    Image(uiImage: identifier)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 440, height: 440)
                        .onLongPressGesture(minimumDuration: 0.5) {
                            withAnimation {
                                generatedImage = identifier
                                viewModel.isPopListShown = true
                            }
                        }

                    Spacer()

                    if viewModel.isPopListShown {
                        popListView
                    }

                    closeButton
                }

            } else {
                if viewModel.isLoading {
                    loadingView
                }
            }
        }
    }
}
