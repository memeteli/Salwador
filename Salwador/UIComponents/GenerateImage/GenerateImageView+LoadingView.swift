//
//  GenerateImageView+LoadingView.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 02.03.23.
//

import SwiftUI

var loadingView: some View {
    VStack {
        ProgressView()
            .foregroundColor(.white)
        Text("Your image is being generated...")
            .font(.title3)
            .foregroundColor(Color("TextColor"))
    }
}
