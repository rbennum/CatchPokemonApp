//
//  PokemonCollectionPresenter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 07/02/22.
//

import Foundation
import RealmSwift

class PokemonCollectionPresenter: PresenterPokemonCollectionProtocol {
    var view: ViewPokemonCollectionProtocol?
    var router: RouterPokemonCollectionProtocol?
    var interactor: InteractorPokemonCollectionProtocol?
    
    private var pokemonList: Results<PokemonDetailResponse>?
    
    func loadPokemonList() {
        view?.showLoading()
        interactor?.fetchPokemonList()
    }
    
    func currentPokemon(_ indexPath: IndexPath) -> PokemonDetailResponse {
        guard let list = pokemonList else {
            return PokemonDetailResponse()
        }
        
        return list[indexPath.row]
    }
    
    func numberOfRowsInSection() -> Int {
        return pokemonList?.count ?? 1
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let pokemon = pokemonList?[indexPath.row] else { return }
        router?.pushToPokemonDetail(on: view, with: pokemon)
    }
}

extension PokemonCollectionPresenter: PresenterToInteractorPokemonCollectionProtocol {
    func onLoadPokemonListSuccess(_ pokemonList: Results<PokemonDetailResponse>?) {
        self.pokemonList = pokemonList
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.onFetchPokemonListSuccess()
        }
    }
    
    func onLoadPokemonListFailed(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.router?.pushToAlertDialog(on: self?.view, with: error.localizedDescription)
        }
    }
}
