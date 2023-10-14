//
//  Profile.swift
//  ProgressEffect
//
//  Created by Bao Hoang on 14/10/2023.
//

import SwiftUI

// Profile Model with Sample Data
struct Collect: Identifiable {

    var id = UUID()
    var imageName: String
    var image: String
    var description: String
}

var collects: [Collect] = [
    Collect(imageName: "img_0", image: "img_0", description: "Moutain & Lake"),
    Collect(imageName: "img_1", image: "img_1", description: "Moutain"),
    Collect(imageName: "img_2", image: "img_2", description: "Lake"),
    Collect(imageName: "img_3", image: "img_3", description: "Star"),
    Collect(imageName: "img_4", image: "img_4", description: "Bird")
]
