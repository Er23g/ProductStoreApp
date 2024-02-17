//
//  ProductsViewModel.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation

class ProductsViewModel {
    
    var view: ProductsViewProtocol?
    var productsArray: [RecommendedItemModel] = [] {
        didSet {
            view?.reloadData()
        }
    }
    var pageContent: PageContentModel!
    
    var page: Int = 0
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getProducts() {
        Task {
            do {
                page += 1
                pageContent = try await apiClient.getListOfProducts(page: self.page)
                productsArray.append(contentsOf: pageContent.nullPageContent?[2].carouselContent?.recommendedItems ?? [])
            
            } catch {
                print("Ocurrió un error")
            }
        }
    }
}
