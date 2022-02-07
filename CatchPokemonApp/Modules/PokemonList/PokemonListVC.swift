//
//  PokemonListVC.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import UIKit
import Kingfisher

class PokemonListVC: UIViewController, ViewPokemonListProtocol {
    @IBOutlet weak var habitatTitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pokemonListTableView: UITableView!
    
    lazy var pokeballButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pokeball"), for: .normal)
        button.addTarget(self, action: #selector(pokeballButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var presenter: PresenterPokemonListProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadPokemonList()
    }
    
    func showLoading() {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
    }
    
    func onGetPokemonListSuccess() {
        pokemonListTableView.reloadData()
    }
}

private extension PokemonListVC {
    func setupUI() {
        navigationItem.title = "Pokemon List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pokeballButton)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: presenter?.getHabitat().uppercased(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popToPrevious))
        habitatTitleLabel.text = presenter?.getHabitat().uppercased()
        pokemonListTableView.rowHeight = 70
        pokemonListTableView.separatorStyle = .none
        pokemonListTableView.delegate = self
        pokemonListTableView.dataSource = self
        pokemonListTableView.register(UINib(nibName: "\(PokemonListTVC.self)", bundle: nil),
                                      forCellReuseIdentifier: PokemonListTVC.identifier)
    }
    
    @objc func pokeballButtonClicked() {
        presenter?.openPokemonCollectionPage()
    }
    
    @objc func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
}

extension PokemonListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(indexPath)
    }
}

extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTVC.identifier,
                                                       for: indexPath) as? PokemonListTVC else {
            return UITableViewCell()
        }
        
        let selectedPokemon = presenter?.currentPokemon(indexPath)
        cell.pokemonImageView.kf.setImage(with: URL(string: selectedPokemon?.imageURL ?? ""))
        cell.pokemonNameLabel.text = selectedPokemon?.name?.uppercased()
        return cell
    }
}
