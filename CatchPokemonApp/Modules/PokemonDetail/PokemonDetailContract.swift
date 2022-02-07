//
//  PokemonDetailContract.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation
import RealmSwift

protocol ViewPokemonDetailProtocol {
    var presenter: PresenterPokemonDetailProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func enableActionButton()
    func disableActionButton()
    func onPokemonDetailSuccess(_ response: PokemonDetailResponse)
}

protocol PresenterPokemonDetailProtocol {
    var view: ViewPokemonDetailProtocol? { get set }
    var interactor: InteractorPokemonDetailProtocol? { get set }
    var router: RouterPokemonDetailProtocol? { get set }
    
    var pokemonDetail: PokemonDetailResponse? { get set }
    var pokemonID: String? { get set }
    var isFromPokemonCollectionPage: Bool? { get set }
    
    func loadPokemonDetail()
    func actionPokemon()
}

protocol PresenterToInteractorPokemonDetailProtocol {
    func onFetchPokemonDetailSuccess(_ response: PokemonDetailResponse)
    func onFetchPokemonDetailFailed(_ error: Error)    
    func onPokemonCapturedSuccess()
}

protocol InteractorPokemonDetailProtocol {
    var presenter: PresenterToInteractorPokemonDetailProtocol? { get set }
    
    func fetchPokemonDetail(by pokemonID: String)
    func catchPokemon(_ pokemon: PokemonDetailResponse)
    func releasePokemon(_ pokemon: PokemonDetailResponse)
    func setNewNickname(_ id: ObjectId, _ nickname: String)
}

protocol RouterPokemonDetailProtocol {
    static func createModule() -> PokemonDetailVC
    
    func pushToAlertDialog(on view: ViewPokemonDetailProtocol?, with errorMessage: String)
    func dismissPage(on view: ViewPokemonDetailProtocol?)
    func pushToNicknameDialog(on view: ViewPokemonDetailProtocol?, _ alertAction: ((String?) -> Void)?)
}
