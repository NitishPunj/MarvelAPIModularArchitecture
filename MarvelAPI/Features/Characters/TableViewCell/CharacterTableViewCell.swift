//
//  CharacterTableViewCell.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import UIKit
import MarvelAPIService

final class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var viewModel: MarvelCharacter? {
        didSet {
            nameLabel.text = viewModel?.name
            if let imageURL = viewModel?.imageURL {
                logoImage.loadImageUsingCache(withUrl: imageURL)
            }
        }
    }
}

