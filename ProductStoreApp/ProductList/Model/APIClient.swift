//
//  APIClient.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation

final class ApiClient {
    
    let headers = ["Content-Type": "application/json"]

    func getListOfProducts(page: Int) async throws -> PageContentModel {
    let url = URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v7/plp/sf?page-number=\(page)&search-string=%7B%7Btermino-de-busqueda%7D%7D&sort-option=&force-plp=false&number-of-items-per-page=40&cleanProductName=false")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        
        let products: PageContentModel = try JSONDecoder().decode(PageContentModel.self, from: data)
        //print(products)
        
        return products
    }
    
}
