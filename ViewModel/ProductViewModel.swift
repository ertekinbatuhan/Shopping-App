//
//  ProductViewModel.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 5.12.2023.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseCore

class ProductViewModel {
    
    var productNameArray =  BehaviorSubject<[String]>(value: [String]())
    var productPictureArray = BehaviorSubject<[String]>(value: [String]())
    var productRepository = ProductDaoRepository()
    
    init() {
        
        productNameArray = productRepository.productNameArray
        productPictureArray = productRepository.productPictureArray
        loadProducts()
    }
    
    func loadProducts() {
        productRepository.loadData()
        
    }
    
}
