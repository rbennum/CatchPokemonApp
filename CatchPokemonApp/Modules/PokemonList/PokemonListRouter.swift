//
//  PokemonListRouter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import Foundation
import UIKit

class PokemonListRouter: RouterPokemonListProtocol {
    static func createModule() -> UINavigationController {
        let vc = PokemonListVC()
        let rootVC = UINavigationController(rootViewController: vc)
        let presenter: PresenterPokemonListProtocol & PresenterToInteractorPokemonListProtocol = PokemonListPresenter()
        vc.presenter = presenter
        vc.presenter?.router = PokemonListRouter()
        vc.presenter?.interactor = PokemonListInteractor()
        vc.presenter?.view = vc
        vc.presenter?.interactor?.presenter = presenter
        
        return rootVC
    }
    
    func pushToPokemonDetail(on view: ViewPokemonListProtocol?, with pokemonID: String) {
        let vc = PokemonDetailRouter.createModule()
        vc.presenter?.pokemonID = pokemonID
        vc.presenter?.isFromPokemonCollectionPage = false
        (view as? PokemonListVC)?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToAlertDialog(on view: ViewPokemonListProtocol?, with errorMessage: String) {
        let alertDialog = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        (view as? PokemonListVC)?.present(alertDialog, animated: true, completion: nil)
    }
    
    func pushToPokemonCollection(on view: ViewPokemonListProtocol?) {
        let vc = PokemonCollectionRouter.createModule()
        (view as? PokemonListVC)?.navigationController?.pushViewController(vc, animated: true)
    }
}
