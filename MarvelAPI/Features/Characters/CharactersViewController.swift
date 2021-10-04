//
//  CharactersViewController.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import UIKit
import MarvelAPIService

protocol CharactersViewControllerCoordinator {
    func showDetail(character: MarvelCharacter)
}


final class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: CharactersViewModel
    private let coordinator: CharactersViewControllerCoordinator?
    
    // MARK: - CharactersViewController: Initialiser
    /// Initializer Injection
    init(viewModel: CharactersViewModel, coordinator: CharactersViewControllerCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: CharactersViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - CharactersViewController: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Marvel Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        fetchData()
        
        
    }
    
    // MARK: - CharactersViewController : FetchData
    private func fetchData() {
        viewModel.fetchData { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - CharactersViewController: UITableViewDataSource
extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.characters[indexPath.row]
        coordinator?.showDetail(character: cellViewModel)
    }
}


// MARK: -  CharactersViewController: UITableViewDataSource
extension CharactersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            return .init()}
        
        cell.viewModel = viewModel.characters[indexPath.row]
        return cell
    }
}
