//
//  PokemonCollectionInteractor.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 07/02/22.
//

import Foundation
import RealmSwift

class PokemonCollectionInteractor: InteractorPokemonCollectionProtocol {
    var presenter: PresenterToInteractorPokemonCollectionProtocol?
    
    private let realm = try! Realm()
    
    func fetchPokemonList() {
        presenter?.onLoadPokemonListSuccess(realm.objects(PokemonDetailResponse.self))
    }
}
