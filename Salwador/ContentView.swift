//
//  ContentView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 31.01.23.
//

import SwiftUI



struct ContentView: View {

    var body: some View {
              ZStack{
                        Color(.black)
                   
                                  .ignoresSafeArea()
                        VStack {
                                  Button("Tap on me") {
                                
                                            print("hello world")
                                  }
                                  Image("salvador-man").resizable()
                                            .cornerRadius(15)
                                            .aspectRatio(contentMode: .fit)
                                  Text("Salvador iOS App")
                                            .font(.title)
                                            .fontWeight(.bold)
                                  
                        }
              }

        
        .padding()
    }
}

func validate () {
          print("text fiedld");
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
