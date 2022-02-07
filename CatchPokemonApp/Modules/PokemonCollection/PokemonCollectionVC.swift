//
//  PokemonCollectionVC.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 07/02/22.
//

import UIKit

class PokemonCollectionVC: UIViewController, ViewPokemonCollectionProtocol {
    @IBOutlet weak var pokemonCapturedTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: PresenterPokemonCollectionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func onFetchPokemonListSuccess() {
        pokemonCapturedTableView.reloadData()
    }
}

private extension PokemonCollectionVC {
    func setupUI() {
        navigationItem.title = "Pokemon Collection"
        pokemonCapturedTableView.rowHeight = 70
        pokemonCapturedTableView.separatorStyle = .none
        pokemonCapturedTableView.delegate = self
        pokemonCapturedTableView.dataSource = self
        pokemonCapturedTableView.register(UINib(nibName: "\(PokemonListTVC.self)", bundle: nil),
                                          forCellReuseIdentifier: PokemonListTVC.identifier)
    }
}

extension PokemonCollectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
}

extension PokemonCollectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTVC.identifier,
                                                       for: indexPath) as? PokemonListTVC else {
            return UITableViewCell()
        }
        
        let selectedPokemon = presenter?.currentPokemon(indexPath)
        cell.pokemonImageView.kf.setImage(with: URL(string: selectedPokemon?.sprite ?? ""))
        cell.pokemonNameLabel.text = selectedPokemon?.name?.uppercased()
        return cell
    }
}
