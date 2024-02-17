//
//  String+Extensions.swift
//  ProductStoreApp
//
//  Created by Edgar Gerardo Flores López on 16/02/24.
//

import Foundation
import UIKit

extension String {

    func strikedThrough() -> NSAttributedString {
        let strikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        return NSAttributedString(string: self, attributes: strikethroughStyle)
    }

}
