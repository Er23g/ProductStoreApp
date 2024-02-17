//
//  RecommendedItemModel.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation

struct RecommendedItemModel: Codable {
    let displayName: String?
    let largeImage: String?
    let productId: String?
    let listPrice: Double?
    let promoPrice: Double?
    let salePrice: Double?
    let variantsInfo: [VariantInfoModel]?
}
