//
//  Locations.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation

struct Locations {
    private static let habitatList: [String] = [
        "grassland",
        "forest",
        "sea",
        "cave",
        "mountain",
        "urban",
        "rare",
    ]
    
    static var pickHabitat: String {
        get {
            let randomIndex = Int.random(in: 0..<habitatList.count)
            return habitatList[randomIndex]
        }
    }
}
