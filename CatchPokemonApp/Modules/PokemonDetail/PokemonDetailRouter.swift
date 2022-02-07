//
//  PokemonDetailRouter.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import Foundation
import UIKit

class PokemonDetailRouter: RouterPokemonDetailProtocol {
    static func createModule() -> PokemonDetailVC {
        let vc = PokemonDetailVC()
        let presenter: PresenterPokemonDetailProtocol & PresenterToInteractorPokemonDetailProtocol = PokemonDetailPresenter()
        vc.presenter = presenter
        vc.presenter?.router = PokemonDetailRouter()
        vc.presenter?.interactor = PokemonDetailInteractor()
        vc.presenter?.view = vc
        vc.presenter?.interactor?.presenter = presenter
        
        return vc
    }
    
    func pushToAlertDialog(on view: ViewPokemonDetailProtocol?, with errorMessage: String) {
        let alertDialog = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        (view as? PokemonDetailVC)?.present(alertDialog, animated: true, completion: nil)
    }
    
    func dismissPage(on view: ViewPokemonDetailProtocol?) {
        (view as? PokemonDetailVC)?.navigationController?.popViewController(animated: true)
    }
    
    func pushToNicknameDialog(on view: ViewPokemonDetailProtocol?, _ alertAction: ((String?) -> Void)?) {
        var alertTextField: UITextField?
        let alertVC = UIAlertController(title: "Set a nickname for your new Pokemon?", message: "", preferredStyle: .alert)
        alertVC.addTextField { textField in
            alertTextField = textField
        }
        let action = UIAlertAction(title: "Set nickname", style: .default) { action in
            alertAction?(alertTextField?.text)
        }
        alertVC.addAction(action)
        (view as? PokemonDetailVC)?.present(alertVC, animated: true, completion: nil)
    }
}
