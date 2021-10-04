//
//  MarvelAPIServiceProtocol.swift
//
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import Networking
import Foundation

public protocol  MarvelAPIServicing {
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], Error>)->Void)
}

public final class MarvelService: MarvelAPIServicing {
    private let dispatcher: NetworkRequestDispatcing
    private let decoder: JSONDecoder
    
    public convenience init() {
        self.init(dispatcher: NetworkRequestDispatcher(), decoder: JSONDecoder())
    }
    
    init(dispatcher: NetworkRequestDispatcing = NetworkRequestDispatcher(), decoder: JSONDecoder = JSONDecoder()) {
        self.dispatcher = dispatcher
        self.decoder = decoder
    }
    
    public func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], Error>)->Void) {
        guard let url = URL(string: MarvelURLEndpoint.characters) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        dispatcher.execute(request: urlRequest) { [weak self] result in
            guard let self = self else{ return }
            switch result {
            case .success(let data):
                if let jsonData = data {
                    do {
                        let responseModel =  try self.decoder.decode(CharacterResponseModel.self, from: jsonData)
                        completion(.success(responseModel.data.characters))
                    }
                    catch (let error) {
                        print(error)
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
