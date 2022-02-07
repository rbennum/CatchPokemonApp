//
//  PokemonCollectionContract.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 07/02/22.
//

import Foundation
import RealmSwift

protocol ViewPokemonCollectionProtocol {
    var presenter: PresenterPokemonCollectionProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func onFetchPokemonListSuccess()
}

protocol PresenterPokemonCollectionProtocol {
    var view: ViewPokemonCollectionProtocol? { get set }
    var router: RouterPokemonCollectionProtocol? { get set }
    var interactor: InteractorPokemonCollectionProtocol? { get set }
    
    func loadPokemonList()
    func currentPokemon(_ indexPath: IndexPath) -> PokemonDetailResponse
    func numberOfRowsInSection() -> Int
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol PresenterToInteractorPokemonCollectionProtocol {
    func onLoadPokemonListSuccess(_ pokemonList: Results<PokemonDetailResponse>?)
    func onLoadPokemonListFailed(_ error: Error)
}

protocol InteractorPokemonCollectionProtocol {
    var presenter: PresenterToInteractorPokemonCollectionProtocol? { get set }
    
    func fetchPokemonList()
}

protocol RouterPokemonCollectionProtocol {
    static func createModule() -> PokemonCollectionVC
    
    func pushToPokemonDetail(on view: ViewPokemonCollectionProtocol?, with pokemon: PokemonDetailResponse)
    func pushToAlertDialog(on view: ViewPokemonCollectionProtocol?, with message: String)
}
