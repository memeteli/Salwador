//
//  ContentView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 31.01.23.
//

import SwiftUI



struct ContentView: View {

          @State private var text: String = ""
          @State private var savedText: String = ""
          @State private var descriptionText: String = "Your promp will be shown here"

          var body: some View {
              ZStack{
                        Color(red: 0.0, green: 0.4666666666666667, blue: 0.7137254901960784)
                                                      .ignoresSafeArea()
    VStack() {
              appNameView
           editorViewDescription
              textEditorView
              submitButton
              submittedTextDescription
              submittedText
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
                              .font(.title)
                              .fontWeight(.bold)
                              .padding(.bottom, 30)
                    
          }
          var textEditorView: some View {
                    TextEditor(text: $text)
                              .background(Color(.red))
                              .font(.title2)
                              .frame(height: 250)
                              .border(Color(.black), width: 1)
                              .padding(10)
                                             .onTapGesture {}
          }
          
          var editorViewDescription: some View {
                    Text("Please enter your promp in the editor")
                              .font(.title2)
          }
          
          var submitButton: some View {
                    Button("Submit") {
                              print("the user has submitted", $text)
                              savePromp()
                    }
                    .frame(width: 120)
                      .foregroundColor(.white)
                      .background(Color(red: 0.0, green: 0.5882352941176471, blue: 0.7803921568627451))
                      .cornerRadius(10)
                      .padding(10)
          }
          
          var submittedText: some View {
                    Text(savedText)
          }
          
          var submittedTextDescription: some View {
                    Text(descriptionText)
                              .font(.title3)
                              .foregroundColor(Color(red: 0.6784313725490196, green: 0.9098039215686274, blue: 0.9568627450980393))
                              .multilineTextAlignment(.leading)
          }
          
          private func savePromp() {
               savedText = text
                    descriptionText = "You have entered following prompt: "
           }
}

