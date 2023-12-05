//
//  CartViewModel.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 5.12.2023.
//

import Foundation
import RxSwift

class CartViewModel {
    
    var productNameArray =  BehaviorSubject<[String]>(value: [String]())
    var productPictureArray = BehaviorSubject<[String]>(value: [String]())
    var cardRepository = CartDaoRepository()
    
    init() {
        
        productNameArray = cardRepository.productNameArray
        productPictureArray = cardRepository.productPictureArray
        loadProducts()
    }
    
    func loadProducts() {
        cardRepository.loadProducts()
        
    }
    
}
