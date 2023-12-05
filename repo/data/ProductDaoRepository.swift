//
//  ProductDaoRepository.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 5.12.2023.
//

import Foundation
import RxSwift
import Firebase
import FirebaseFirestore

class ProductDaoRepository {
    
    var productNameArray =  BehaviorSubject<[String]>(value: [String]())
    var productPictureArray = BehaviorSubject<[String]>(value: [String]())
   
    func loadData() {
        
        let db = Firestore.firestore()
        var nameArray = [String]()
        var pictureArray = [String]()

        db.collection("products").addSnapshotListener{ snapshots, error in
            
            if error != nil {
                
                print(error?.localizedDescription)
                
            } else {
                
                nameArray.removeAll()
                pictureArray.removeAll()
            
                for document in snapshots!.documents {
                    
                    if let productName = document.get("Product Name") as?  String {
                        
                        nameArray.append(productName)
                        self.productNameArray.onNext(nameArray)
                        
                    }
                    
                    if let productPicture = document.get("Product Picture : ") as? String {
                        
                        pictureArray.append(productPicture)
                        self.productPictureArray.onNext(pictureArray)
                    
                    }
                }
              //  self.collectionView.reloadData()
            }
        }
    }
    

    
}
