//
//  CartDaoRepository.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 5.12.2023.
//

import Foundation
import RxSwift
import Firebase
class CartDaoRepository {
    
    var productNameArray = BehaviorSubject<[String]>(value: [String]())
    var productPictureArray = BehaviorSubject<[String]>(value: [String]())
   
    func loadProducts() {
        let db = Firestore.firestore()
        db.collection("selectedProducts").addSnapshotListener { snapshots, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            var nameArray = [String]()
            var pictureArray = [String]()
            var idArray = [String]()
            
            for document in snapshots!.documents {
                if let productName = document.get("Product Name") as? String {
                    nameArray.append(productName)
                }
                
                if let productPicture = document.get("Product Picture") as? String {
                    pictureArray.append(productPicture)
                }
            }
            
            self.productNameArray.onNext(nameArray)
            self.productPictureArray.onNext(pictureArray)
          
        }
    }
}
