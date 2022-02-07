//
//  PokemonListPresenter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation
import UIKit

class PokemonListPresenter: PresenterPokemonListProtocol {
    var view: ViewPokemonListProtocol?
    var interactor: InteractorPokemonListProtocol?
    var router: RouterPokemonListProtocol?
    
    var pokemonList: [GeneralInfo]?
    
    private var selectedHabitat: String = ""
    
    func getHabitat() -> String {
        selectedHabitat = Locations.pickHabitat
        return selectedHabitat
    }
    
    func loadPokemonList() {
        if selectedHabitat.isEmpty {
            selectedHabitat = Locations.pickHabitat
        }
        
        view?.showLoading()
        interactor?.fetchPokemonList(by: selectedHabitat)
    }
    
    func numberOfRowsInSection() -> Int {
        return pokemonList?.count ?? 0
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        guard let pokemonList = pokemonList else {
            return
        }

        let selectedPokemonID = pokemonList[indexPath.row].ID
        router?.pushToPokemonDetail(on: view, with: selectedPokemonID)
    }
    
    func currentPokemon(_ indexPath: IndexPath) -> GeneralInfo? {
        return pokemonList?[indexPath.row]
    }
    
    func openPokemonCollectionPage() {
        router?.pushToPokemonCollection(on: view)
    }
}

extension PokemonListPresenter: PresenterToInteractorPokemonListProtocol {
    func onFetchPokemonListSuccess(_ response: PokemonHabitatResponse) {
        pokemonList = response.pokemonSpecies ?? []
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.onGetPokemonListSuccess()
        }
    }
    
    func onFetchPokemonFailed(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.router?.pushToAlertDialog(on: self?.view, with: error.localizedDescription)
        }
    }
}
