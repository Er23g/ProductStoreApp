//
//  ProductsViewController.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import UIKit

protocol ProductsViewProtocol {
    func reloadData()
}

class ProductsViewController: UIViewController {
    
    private let productsViewModel = ProductsViewModel(apiClient: ApiClient())

    private lazy var productsTableView: UITableView = {
        let pTableView = UITableView()
        pTableView.translatesAutoresizingMaskIntoConstraints = false
        pTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.cellName)
        pTableView.dataSource = self
        pTableView.delegate = self
        pTableView.prefetchDataSource = self
        return pTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsViewModel.view = self
        getProducts()

        setupView()        
    }
    
    func setupView() {
        view.addSubview(productsTableView)
        
        NSLayoutConstraint.activate([
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getProducts() {
        productsViewModel.getProducts()
    }

}

extension ProductsViewController: ProductsViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
}

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsViewModel.productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellName, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ProductTableViewCell {
            cell.configure(productName: productsViewModel.productsArray[indexPath.row].displayName ?? "", productImage: productsViewModel.productsArray[indexPath.row].largeImage ?? "", productPrice: productsViewModel.productsArray[indexPath.row].listPrice ?? 0.0, productFinalPrice: productsViewModel.productsArray[indexPath.row].promoPrice ?? 0.0, productVariants: productsViewModel.productsArray[indexPath.row].variantsInfo ?? [])
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row == productsViewModel.productsArray.count - 1 }) {
            productsViewModel.getProducts()
        }
    }
    
}
