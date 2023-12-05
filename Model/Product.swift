//
//  Product.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 29.11.2023.
//

import Foundation


struct Product {
    var product_id = UUID().uuidString
    var product_name : String
    var product_picture : String
    
    init(product_id: String = UUID().uuidString, product_name: String, product_picture: String) {
        self.product_name = product_name
        self.product_picture = product_picture
    }
    
    
}
