//
//  PokemonListInteractor.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation

class PokemonListInteractor: InteractorPokemonListProtocol {
    var presenter: PresenterToInteractorPokemonListProtocol?
    
    private let baseURL = "https://pokeapi.co/api/v2"
    
    func fetchPokemonList(by habitat: String) {
        guard let url = URL(string: "\(baseURL)/pokemon-habitat/\(habitat)") else {
            presenter?.onFetchPokemonFailed(DataPokemonError.url)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300) ~= httpResponse.statusCode,
                  let data = data else {
                      self?.presenter?.onFetchPokemonFailed(DataPokemonError.network)
                      return
                  }
            var decodedResponse: PokemonHabitatResponse = PokemonHabitatResponse(pokemonSpecies: [])
            
            do {
                decodedResponse = try JSONDecoder().decode(PokemonHabitatResponse.self, from: data)
            } catch let DecodingError.dataCorrupted(context) {
                self?.presenter?.onFetchPokemonFailed(DecodingError.dataCorrupted(context))
            } catch let DecodingError.keyNotFound(key, context) {
                self?.presenter?.onFetchPokemonFailed(DecodingError.keyNotFound(key, context))
            } catch let DecodingError.valueNotFound(value, context) {
                self?.presenter?.onFetchPokemonFailed(DecodingError.valueNotFound(value, context))
            } catch let DecodingError.typeMismatch(type, context)  {
                self?.presenter?.onFetchPokemonFailed(DecodingError.typeMismatch(type, context))
            } catch {
                self?.presenter?.onFetchPokemonFailed(DataPokemonError.decoding)
            }
            
            if ((decodedResponse.pokemonSpecies ?? []).isEmpty) {
                self?.presenter?.onFetchPokemonFailed(DataPokemonError.emptyPackage)
            } else {
                self?.presenter?.onFetchPokemonListSuccess(decodedResponse)
            }
        }
        
        task.resume()
    }
}
