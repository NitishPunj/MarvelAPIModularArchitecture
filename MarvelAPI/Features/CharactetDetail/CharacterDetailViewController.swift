//
//  CharacterDetailViewController.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import UIKit
import MarvelAPIService

final class CharacterDetailViewController: UIViewController {
    
    
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    private let viewModel: MarvelCharacter
    
    
    /// Initializer Injection
    init(viewModel: MarvelCharacter) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CharacterDetailViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycyle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        descriptionLabel.text = viewModel.description
        
    }

}
