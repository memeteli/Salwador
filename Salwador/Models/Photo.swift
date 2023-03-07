//
//  Photo.swift
//  Salwador
//
//  Created by Ailiniyazi Maimaiti on 27.02.23.
//

import Foundation
import SwiftUI

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    var image: Image
}
