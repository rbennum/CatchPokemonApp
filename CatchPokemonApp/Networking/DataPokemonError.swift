//
//  DataPokemonError.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation

enum DataPokemonError: Error {
    case network
    case decoding
    case url
    case emptyPackage
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        case .url:
            return "Invalid URL"
        case .emptyPackage:
            return "You got an empty payload"
        }
    }
}
