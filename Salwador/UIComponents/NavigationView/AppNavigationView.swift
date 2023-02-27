//
//  AppNavigationView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 24.02.23.
//

import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Color("BackgroundColor")
                    VStack {
                        Spacer()
                        appNameView
                        Spacer()
                        navigationLinksView
                        Spacer()
                    }
                }
            }
            .background(Color("BackgroundColor"))
        }
    }
}

struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}

var appNameView: some View {
    VStack {
        Text("Salvador")
            .foregroundColor(Color("TextColor"))
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 30)

        Image("salvador-icon")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)

        Text("Your AI Image Generator")
            .foregroundColor(Color("TextColor"))
            .font(.footnote)
    }
}

var navigationLinksView: some View {
    VStack {
        NavigationLink(destination: GenerateImageView()) {
            Text("Create your own AI Image")
        }
        .frame(width: 275, height: 75)
        .foregroundColor(.white)
        .background(.pink)
        .cornerRadius(10)
        .padding(40)

        NavigationLink(destination: GenerateSampleImageView()) {
            Text("Get inspired from others")
        }
        .frame(width: 275, height: 75)
        .foregroundColor(.white)
        .background(.pink)
        .cornerRadius(10)
    }
}
