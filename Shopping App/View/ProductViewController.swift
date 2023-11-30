//
//  ProductViewController.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 30.11.2023.
//

import UIKit
import Firebase
import FirebaseFirestore


class ProductViewController: UIViewController {
    
    @IBOutlet weak var productSearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productArray = [Product]()
    var productNameArray = [String]()
    var productPictureArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        loadData()

    }
    
    func loadData() {
        
        let db = Firestore.firestore()
        
        db.collection("products").addSnapshotListener{ snapshots, error in
            
            if error != nil {
                
                print(error?.localizedDescription)
                
            } else {
                for document in snapshots!.documents {
                    
                    if let productName = document.get("Product Name") as?  String {
                        
                        self.productNameArray.append(productName)
                        
                    }
                    
                    if let productPicture = document.get("Product Picture : ") as? String {
                        print(productPicture)
                        
                        self.productPictureArray.append(productPicture)
                        
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }

}

extension ProductViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productNameArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectView", for: indexPath) as! CollectionViewCell
        
        
        cell.imageView.layer.cornerRadius = 10
        cell.imageView.layer.borderWidth = 2.0
        cell.imageView.layer.borderColor = CGColor(gray: 5, alpha: 5)
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = CGColor(gray: 5, alpha: 5  )
        
        cell.imageView.image = UIImage(named:productPictureArray[indexPath.row])
        cell.productName.text = productNameArray[indexPath.row]
      
        cell.buttonClicked = {

            let db = Firestore.firestore()
            
            db.collection("selectedProducts").document().setData([
                "Product Id" : UUID().uuidString,
                "Product Name" : self.productNameArray[indexPath.row],"Product Picture" : self.productPictureArray[indexPath.row]])
            
        }
    
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    
    
}



