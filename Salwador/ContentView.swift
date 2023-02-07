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
          @State private var savedText: String = ""
          @State private var descriptionText: String = "Your promp will be shown here"
          @State private var imagePath:String = "salvador-man"
                    @State private var image: UIImage? = nil
                    @State private var isLoading: Bool = false
                    
                    var body: some View {
              ZStack{
                        Color(red: 0.0, green: 0.4666666666666667, blue: 0.7137254901960784)
         
    VStack(spacing: 10) {
              appNameView
              editorViewDescriptionView
              textEditorView
              submitButtonView
              submittedTextDescriptionView
              submittedText
              imageView
    }
                    
              }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


private extension ContentView {
          var appNameView: some View {
                    Text("Salvador")
                               .foregroundColor(Color(red: 0.792156862745098, green: 0.9411764705882353, blue: 0.9725490196078431))
                              .font(.title)
                              .fontWeight(.bold)
                              .padding(.bottom, 30)
                    
          }
                    
          var textEditorView: some View {
                              ZStack{
                                                  TextEditor(
                                                            text: $prompText)
                                   .background(Color(.red))
                    .font(.title2)
                                                            .frame(minWidth: 320, idealWidth: 500, maxWidth: .infinity, minHeight: 100, idealHeight: 200, maxHeight: .infinity)
                                                                     .scaledToFit()
                                                            .border(Color(.black), width: 1)
                                                            .padding(10)
                                                            .cornerRadius(10)
                                                            .onTapGesture {}
                              }
                              .background(Rectangle()
                                        .foregroundColor(Color(hue: 0.564, saturation: 0.583, brightness: 0.63))
                                        .shadow(radius: 15))
          }
          
          var editorViewDescriptionView: some View {
                    Text("Please enter your promp in the editor")
                              .foregroundColor(Color(red: 0.792156862745098, green: 0.9411764705882353, blue: 0.9725490196078431))
                              .font(.title2)
          }
          
          var submitButtonView: some View {
                    Button("Submit") {
                                        isLoading = true
                                        savePromp()
                                        sendRequest(prompText: prompText)

                    }
                    .frame(width: 150, height: 50)
                      .foregroundColor(.white)
                      .background(Color(red: 0.0, green: 0.5882352941176471, blue: 0.7803921568627451))
                      .cornerRadius(10)
                      .padding(10)
          }
          
          var submittedText: some View {
                    Text(savedText)
          }
          
          var submittedTextDescriptionView: some View {
                    Text(descriptionText)
                              .font(.title3)
                              .foregroundColor(Color(red: 0.6784313725490196, green: 0.9098039215686274, blue: 0.9568627450980393))
                              .multilineTextAlignment(.leading)
          }
                    
                    var imageView: some View {
                                        VStack {
                                                            if let image {
                                                                                Image(uiImage: image)
                                                                                                    .resizable()
                                                                                                    .foregroundColor(Color.red)
                                                                                                    .scaledToFit()
                                                                                                    .frame(width: 400, height: 200)
                                                            } else {
                                                                                Image(imagePath)
                                                                                                    .resizable()
                                                                                                    .foregroundColor(Color.red)
                                                                                                    .scaledToFit()
                                                                                                    .frame(width: 400, height: 200)
                                                            }
                                                            
                                                            if isLoading {
                                                                     ProgressView()
                                                            }
                                        }
                            
                    }
                                        
          
          private func savePromp() {
               savedText = prompText
               descriptionText = "You have entered following prompt: "
           }
                    
                    private func sendRequest(prompText: String) {
                                        Task {
                                                            do {
                                                                                let response = try await ImageGenerator.shared.generateImage(withPrompt: prompText, apiKey: "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")
                                                                                
                                                                                if let url = response.data.map(\.url).first {
                                                                                                    let (data, _) = try await URLSession.shared.data(from: url)
                                                           image = UIImage(data: data)
                                                                isLoading = false
                                                                                }
                                                            }
                                                            catch {
                                                                                print(error)
                                                                                
                                                            }
                                        }
                    }
}

