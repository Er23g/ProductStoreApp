//
//  ContentModel.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation

struct ContentModel: Codable {
    let carouselContent: CarouselContentModel?
    let type: String?
    
    /*enum CodingKeys: String, CodingKey {
        case carouselContent
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        carouselContent = try container.decode(CarouselContentModel.self, forKey: .carouselContent)
        type = try container.decode(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(carouselContent, forKey: .carouselContent)
        try container.encode(type, forKey: .type)
    }*/

}
