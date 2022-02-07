//
//  PokemonDetailPresenter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation

class PokemonDetailPresenter: PresenterPokemonDetailProtocol {
    var view: ViewPokemonDetailProtocol?
    var interactor: InteractorPokemonDetailProtocol?
    var router: RouterPokemonDetailProtocol?
    
    var pokemonDetail: PokemonDetailResponse?
    var pokemonID: String?
    var isFromPokemonCollectionPage: Bool? = false
    
    func loadPokemonDetail() {
        if isFromPokemonCollectionPage ?? false {
            view?.onPokemonDetailSuccess(pokemonDetail ?? PokemonDetailResponse())
            return
        }
        
        guard let pokemonID = pokemonID else {
            router?.pushToAlertDialog(on: view, with: "Missing pokemon ID")
            return
        }

        view?.showLoading()
        view?.enableActionButton()
        interactor?.fetchPokemonDetail(by: pokemonID)
    }
    
    func actionPokemon() {
        guard let isFromPokemonCollectionPage = isFromPokemonCollectionPage, let pokemon = pokemonDetail else { return }
        
        if isFromPokemonCollectionPage {
            interactor?.releasePokemon(pokemon)
            router?.dismissPage(on: view)
        } else {
            let chance = Int.random(in: 1...100)
            if chance > 50 {
                interactor?.catchPokemon(pokemon)
                print("Captured the pokemon")
            } else {
                router?.pushToAlertDialog(on: view, with: "Failed to catch the pokemon")
            }
            
            view?.disableActionButton()
        }
    }
}

extension PokemonDetailPresenter: PresenterToInteractorPokemonDetailProtocol {
    func onFetchPokemonDetailSuccess(_ response: PokemonDetailResponse) {
        pokemonDetail = response
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.onPokemonDetailSuccess(response)
        }
    }
    
    func onFetchPokemonDetailFailed(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.router?.pushToAlertDialog(on: self?.view, with: error.localizedDescription)
        }
    }
    
    func onPokemonCapturedSuccess() {
        router?.pushToNicknameDialog(on: view) { [weak self] newNickname in
            guard let id = self?.pokemonDetail?._id else { return }
            
            self?.interactor?.setNewNickname(id, newNickname ?? "Hello")
        }
    }
}
