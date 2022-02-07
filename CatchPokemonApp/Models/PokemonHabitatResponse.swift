//
//  PokemonHabitatResponse.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation

struct PokemonHabitatResponse: Codable {
    let pokemonSpecies: [GeneralInfo]?
    
    enum CodingKeys: String, CodingKey {
        case pokemonSpecies = "pokemon_species"
    }
}

struct GeneralInfo: Codable {
    let name: String?
    let url: String?
    
    var ID: String {
        get {
            guard let url = url else { return "" }
            return url.components(separatedBy: "/")[6]
        }
    }
    
    var imageURL: String {
        get {
            return String(format: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%@.png", ID)
        }
    }
}
