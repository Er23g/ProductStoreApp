//
//  StyleVariantsCollectionViewCell.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation
import UIKit

class StyleVariantsCollectionViewCell: UICollectionViewCell {
    
    static let cellName: String = "styleVariantsCollectionViewCell"
    
    private lazy var cardImage: UIView = {
        let cImage = UIImageView()
        cImage.translatesAutoresizingMaskIntoConstraints = false
        cImage.contentMode = .scaleAspectFit
        cImage.backgroundColor = .red
        return cImage
    }()
        
    private lazy var detailLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.text = "Nombre"
        dLabel.textColor = UIColor.white
        dLabel.font = UIFont.systemFont(ofSize: 15.0)
        dLabel.textAlignment = .center
        dLabel.numberOfLines = 2
        return dLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    func configure(name: String, image: String) {
        detailLabel.text = name
    }
    
    func setupView() {
        addSubview(cardImage)
        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            cardImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            detailLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10.0),
            detailLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -5.0),
            detailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailLabel.widthAnchor.constraint(equalToConstant: 100.0),
            detailLabel.heightAnchor.constraint(equalToConstant: 40.0),
            
        ])
    }
    
}
