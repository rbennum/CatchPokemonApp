//
//  PokemonCollectionRouter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 07/02/22.
//

import Foundation
import UIKit

class PokemonCollectionRouter: RouterPokemonCollectionProtocol {
    static func createModule() -> PokemonCollectionVC {
        let vc = PokemonCollectionVC()
        let presenter: PresenterPokemonCollectionProtocol & PresenterToInteractorPokemonCollectionProtocol = PokemonCollectionPresenter()
        vc.presenter = presenter
        vc.presenter?.router = PokemonCollectionRouter()
        vc.presenter?.interactor = PokemonCollectionInteractor()
        vc.presenter?.view = vc
        vc.presenter?.interactor?.presenter = presenter
        return vc
    }
    
    func pushToPokemonDetail(on view: ViewPokemonCollectionProtocol?, with pokemon: PokemonDetailResponse) {
        let vc = PokemonDetailRouter.createModule()
        vc.presenter?.isFromPokemonCollectionPage = true
        vc.presenter?.pokemonDetail = pokemon
        (view as? PokemonCollectionVC)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToAlertDialog(on view: ViewPokemonCollectionProtocol?, with message: String) {
        let alertDialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        (view as? PokemonCollectionVC)?.present(alertDialog, animated: true, completion: nil)
    }
}
