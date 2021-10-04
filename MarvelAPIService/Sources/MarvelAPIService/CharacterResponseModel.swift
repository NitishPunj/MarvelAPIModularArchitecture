//
//  File.swift
//  
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import Foundation

public struct CharacterResponseModel: Codable {
    public let data: DataClass
}

public struct DataClass: Codable {
    public let characters: [MarvelCharacter]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

public struct MarvelCharacter: Codable {
    public let name, description: String
    public let thumbnail: Thumbnail
    public let urls: [MarvelURL]
}

public struct Thumbnail: Codable {
    public let path: String
    public let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public enum Extension: String, Codable {
    case jpg = "jpg"
}

public struct MarvelURL: Codable {
    public let type: URLType
    public let url: String
}

public enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
 
// MARK: MarvelCharacter extensions for Image URL and Website URL

public extension MarvelCharacter {
    var imageURL: URL? {
        let urlString = String("\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
        return URL(string: urlString)
    }
    
    var websiteURL: URL? {
        let websiteURL = urls.filter { $0.type == .detail }
        guard let urlString = websiteURL.first?.url else { return nil }
        return URL(string: urlString)
    }
}
