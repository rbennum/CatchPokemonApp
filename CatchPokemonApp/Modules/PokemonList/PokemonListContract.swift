//
//  PokemonListContract.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation
import UIKit

protocol ViewPokemonListProtocol {
    var presenter: PresenterPokemonListProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func onGetPokemonListSuccess()
}

protocol PresenterPokemonListProtocol {
    var view: ViewPokemonListProtocol? { get set }
    var interactor: InteractorPokemonListProtocol? { get set }
    var router: RouterPokemonListProtocol? { get set }
    
    var pokemonList: [GeneralInfo]? { get set }
    
    func getHabitat() -> String
    func loadPokemonList()
    func numberOfRowsInSection() -> Int
    func didSelectItemAt(_ indexPath: IndexPath)
    func currentPokemon(_ indexPath: IndexPath) -> GeneralInfo?
    func openPokemonCollectionPage()
}

protocol PresenterToInteractorPokemonListProtocol {
    func onFetchPokemonListSuccess(_ response: PokemonHabitatResponse)
    func onFetchPokemonFailed(_ error: Error)
}

protocol InteractorPokemonListProtocol {
    var presenter: PresenterToInteractorPokemonListProtocol? { get set }
    
    func fetchPokemonList(by habitat: String)
}

protocol RouterPokemonListProtocol {
    static func createModule() -> UINavigationController
    
    func pushToPokemonDetail(on view: ViewPokemonListProtocol?, with pokemonID: String)
    func pushToAlertDialog(on view: ViewPokemonListProtocol?, with errorMessage: String)
    func pushToPokemonCollection(on view: ViewPokemonListProtocol?)
}
