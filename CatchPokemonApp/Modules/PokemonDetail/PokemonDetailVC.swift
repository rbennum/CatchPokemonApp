//
//  PokemonDetailVC.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 06/02/22.
//

import UIKit

class PokemonDetailVC: UIViewController, ViewPokemonDetailProtocol {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var hpStatLabel: UILabel!
    @IBOutlet weak var attackStatLabel: UILabel!
    @IBOutlet weak var defenseStatLabel: UILabel!
    @IBOutlet weak var speedStatLabel: UILabel!
    @IBOutlet weak var spAtkStatLabel: UILabel!
    @IBOutlet weak var spDefStatLabel: UILabel!
    @IBOutlet weak var move1Label: UILabel!
    @IBOutlet weak var move2Label: UILabel!
    @IBOutlet weak var move3Label: UILabel!
    @IBOutlet weak var move4Label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var moveStackView: UIStackView!
    
    var presenter: PresenterPokemonDetailProtocol?
    
    private var pokemonData: PokemonDetailResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadPokemonDetail()
    }
    
    func showLoading() {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
    }
    
    func enableActionButton() {
        actionButton.isEnabled = true
    }
    
    func disableActionButton() {
        actionButton.isEnabled = false
    }
    
    func onPokemonDetailSuccess(_ response: PokemonDetailResponse) {
        pokemonImageView.kf.setImage(with: URL(string: response.sprite ?? ""))
        pokemonNameLabel.text = response.name?.uppercased()
        pokemonHeightLabel.text = "Height: \(response.height ?? 0)dm"
        pokemonWeightLabel.text = "Weight: \(response.weight ?? 0)hg"
        
        for stat in (response.stats) {
            let statName = stat.statName ?? ""
            let baseStat = stat.baseStat ?? 0
            let labelText = "\(statName.uppercased()): \(baseStat)"
            
            switch statName {
            case "hp":
                hpStatLabel.backgroundColor = AppColor.HP_COLOR
                hpStatLabel.text = labelText
                break
            case "attack":
                attackStatLabel.backgroundColor = AppColor.ATTACK_COLOR
                attackStatLabel.text = labelText
                break
            case "defense":
                defenseStatLabel.backgroundColor = AppColor.DEFENSE_COLOR
                defenseStatLabel.text = labelText
                break
            case "special-attack":
                spAtkStatLabel.backgroundColor = AppColor.SPATK_COLOR
                spAtkStatLabel.text = "SP-ATK: \(baseStat)"
                break
            case "special-defense":
                spDefStatLabel.backgroundColor = AppColor.SPDEF_COLOR
                spDefStatLabel.text = "SP-DEF: \(baseStat)"
                break
            default:
                speedStatLabel.backgroundColor = AppColor.SPEED_COLOR
                speedStatLabel.text = labelText
                break
            }
        }
        
        let moves = response.moves.prefix(4)
        
        for move in moves {
            let label = createMoveLabel()
            label.text = move.moveName?.uppercased()
            moveStackView.addArrangedSubview(label)
        }
        
        moveStackView.layoutIfNeeded()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        presenter?.actionPokemon()
    }
}

private extension PokemonDetailVC {
    func setupUI() {
        hpStatLabel.textColor = .white
        attackStatLabel.textColor = .white
        defenseStatLabel.textColor = .white
        speedStatLabel.textColor = .white
        spAtkStatLabel.textColor = .white
        spDefStatLabel.textColor = .white
        let buttonTitle = (presenter?.isFromPokemonCollectionPage ?? false) ? "Release" : "Capture"
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    func createMoveLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
