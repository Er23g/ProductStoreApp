//
//  ProductTableViewCell.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    var variants: [VariantInfoModel]?
    static let cellName: String = "productTableViewCell"
    
    private lazy var productImageView: UIImageView = {
        let pImageView = UIImageView()
        pImageView.translatesAutoresizingMaskIntoConstraints = false
        pImageView.contentMode = .scaleAspectFit
        return pImageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.text = "Descripción del producto Descripción del producto Descripción del producto Descripción del producto"
        dLabel.textColor = UIColor.black
        dLabel.font = UIFont.systemFont(ofSize: 17.0)
        dLabel.numberOfLines = 2
        return dLabel
    }()

    private lazy var productPriceLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.text = "$$$$"
        dLabel.textColor = UIColor.systemGray
        dLabel.font = UIFont.systemFont(ofSize: 12.5)
        return dLabel
    }()
    
    private lazy var productFinalPriceLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.text = "$$$$"
        dLabel.textColor = UIColor.systemRed
        dLabel.font = UIFont.systemFont(ofSize: 14.0)
        return dLabel
    }()
    
    private lazy var styleVariantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 20,
                                height: 20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        //collectionView.delegate = self
        collectionView.register(StyleVariantsCollectionViewCell.self,
                                forCellWithReuseIdentifier: StyleVariantsCollectionViewCell.cellName)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        selectionStyle = .none
    }
        
    func setupView() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productFinalPriceLabel)
        addSubview(styleVariantsCollectionView)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 1.1),
            
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15.0),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5.0),
            productPriceLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            
            productFinalPriceLabel.leadingAnchor.constraint(equalTo: productPriceLabel.leadingAnchor),
            productFinalPriceLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 10.0),
            productFinalPriceLabel.trailingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor),
            
            styleVariantsCollectionView.leadingAnchor.constraint(equalTo: productFinalPriceLabel.leadingAnchor),
            styleVariantsCollectionView.topAnchor.constraint(lessThanOrEqualTo: productFinalPriceLabel.bottomAnchor, constant: 5.0),
            styleVariantsCollectionView.trailingAnchor.constraint(equalTo: productFinalPriceLabel.trailingAnchor),
            styleVariantsCollectionView.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor)

        ])
    }
    
    func configure(productName: String, productImage: String, productPrice: Double, productFinalPrice: Double, productVariants: [VariantInfoModel]) {
        productNameLabel.text = productName
        productPriceLabel.isHidden = productPrice == productFinalPrice
        productPriceLabel.attributedText = "$\(productPrice)".strikedThrough()
        productFinalPriceLabel.text = "$\(productFinalPrice)"
        self.variants = productVariants
        styleVariantsCollectionView.reloadData()
        
        productImageView.image = nil
        
        if let url = URL(string: productImage) {
            
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url) {
                    self.productImageView.image = UIImage(data: data)
                }
            }
        }
        
    }
}

extension ProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.variants?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleVariantsCollectionViewCell.cellName, for: indexPath) as! StyleVariantsCollectionViewCell
        if let variant = variants?[indexPath.row] {
            cell.backgroundColor = UIColor(hex: variant.colorHex ?? "#FFFFFF")

        }
        cell.layer.cornerRadius = 10.0
        return cell
    }
}
