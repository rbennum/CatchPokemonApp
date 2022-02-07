//
//  PokemonDetailInteractor.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation
import RealmSwift

class PokemonDetailInteractor: InteractorPokemonDetailProtocol {
    var presenter: PresenterToInteractorPokemonDetailProtocol?
    
    private let baseURL = "https://pokeapi.co/api/v2"
    private let realm = try! Realm()
    
    func fetchPokemonDetail(by pokemonID: String) {
        guard let url = URL(string: "\(baseURL)/pokemon/\(pokemonID)") else {
            presenter?.onFetchPokemonDetailFailed(DataPokemonError.url)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300) ~= httpResponse.statusCode,
                  let data = data else {
                      self?.presenter?.onFetchPokemonDetailFailed(DataPokemonError.network)
                      return
                  }
            
            var decodedResponse: PokemonDetailResponse? = nil
            
            do {
                decodedResponse = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
            } catch let DecodingError.dataCorrupted(context) {
                self?.presenter?.onFetchPokemonDetailFailed(DecodingError.dataCorrupted(context))
            } catch let DecodingError.keyNotFound(key, context) {
                self?.presenter?.onFetchPokemonDetailFailed(DecodingError.keyNotFound(key, context))
            } catch let DecodingError.valueNotFound(value, context) {
                self?.presenter?.onFetchPokemonDetailFailed(DecodingError.valueNotFound(value, context))
            } catch let DecodingError.typeMismatch(type, context)  {
                self?.presenter?.onFetchPokemonDetailFailed(DecodingError.typeMismatch(type, context))
            } catch {
                self?.presenter?.onFetchPokemonDetailFailed(DataPokemonError.decoding)
            }
            
            if let response = decodedResponse {
                self?.presenter?.onFetchPokemonDetailSuccess(response)
            } else {
                self?.presenter?.onFetchPokemonDetailFailed(DataPokemonError.emptyPackage)
            }
        }
        
        task.resume()
    }
    
    func catchPokemon(_ pokemon: PokemonDetailResponse) {
        realmBlock { [weak self] in
            realm.add(pokemon)
            self?.presenter?.onPokemonCapturedSuccess()
        }
    }
    
    func releasePokemon(_ pokemon: PokemonDetailResponse) {
        realmBlock {
            realm.delete(pokemon)
        }
    }
    
    func setNewNickname(_ id: ObjectId, _ nickname: String) {
        let selectedPokemon = realm.object(ofType: PokemonDetailResponse.self, forPrimaryKey: id)
        realmBlock {
            selectedPokemon?.name = nickname
        }
    }
    
    private func realmBlock(_ block: () -> Void) {
        do {
            try realm.write {
                block()
            }
        } catch {
            presenter?.onFetchPokemonDetailFailed(error)
        }
    }
}
