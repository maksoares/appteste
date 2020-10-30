//
//  Movie.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation

public struct Movie: Decodable {
    
    var movieId: String?
    var title: String?
    var date: Double?
    var image: String?
    var synopsis: String?
    var time: Double?
    var price: Double?
    var people: [Person]?

    enum CodingKeys: String, CodingKey {

        case movieId = "id"
        case title = "title"
        case date = "date"
        case image = "image"
        case synopsis = "synopsis"
        case time = "time"
        case price = "price"
        case people = "people"
    }
 
    struct Person: Codable {
        
        var personId: String?
        var name: String?
        var picture: String?
        
        enum CodingKeys: String, CodingKey {
            case personId = "id"
            case name = "name"
            case picture = "picture"
        }
    }

}
