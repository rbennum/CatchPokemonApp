//
//  PokemonListTVC.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import UIKit

class PokemonListTVC: UITableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        pokemonNameLabel.textColor = .white
    }
    
    static var identifier = {
        return String(describing: PokemonListTVC.self)
    }()
}
