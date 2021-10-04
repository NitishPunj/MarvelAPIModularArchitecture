//
//  CharactersViewModel.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//
import Foundation
import MarvelAPIService


final class CharactersViewModel {
    
    private let service: MarvelAPIServicing
    private (set) var characters = [MarvelCharacter]()
    
    
    init(service: MarvelAPIServicing = MarvelService()) {
        self.service = service
    }
    
    func fetchData(completion: @escaping (Error?) -> Void) {
        service.fetchCharacters { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characters = characters
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
