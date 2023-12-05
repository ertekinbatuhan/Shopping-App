//
//  ProductViewController.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 5.12.2023.
//


import UIKit
import Firebase
import FirebaseFirestore
import RxSwift
import FirebaseCore


class ProductViewController: UIViewController {
    
    @IBOutlet weak var productSearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productArray = [Product]()
    var productNameArray = [String]()
    var productPictureArray = [String]()
    var searchArray = [String]()
    var searchPictureArray = [String]()
    var isSearching = false
    
   var productViewModel = ProductViewModel()
      
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        productSearch.delegate = self
        
       // loadData()
        _ = productViewModel.productNameArray.subscribe(onNext: { data in
            
            self.productNameArray = data
            self.collectionView.reloadData()
           
        })
        _ = productViewModel.productPictureArray.subscribe(onNext: { data in
            
            self.productPictureArray = data
            self.collectionView.reloadData()
            
        })
       
    }
}

extension ProductViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching {
                    
                    return searchArray.count
                    
                } else  {
                    return productNameArray.count
                }
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
        
        if isSearching {
            cell.productName.text = searchArray[indexPath.row]
            cell.imageView.image = UIImage(named:searchPictureArray[indexPath.row] )
            
                } else {
                    cell.productName.text = productNameArray[indexPath.row]
                    cell.imageView.image = UIImage(named: productPictureArray[indexPath.row])
                    
                }
                
        cell.buttonClicked = { [self] in

            productViewModel.addSelectedProduct(productName:productNameArray[indexPath.row], productPicture: productPictureArray[indexPath.row])
            
          //  let db = Firestore.firestore()
            
           // db.collection("selectedProducts").document().setData([
             //   "Product Id" : UUID().uuidString,
             //   "Product Name" : self.productNameArray[indexPath.row],"Product Picture" : self.productPictureArray[indexPath.row]])
            
            
        }
    
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
        
    }
    
    
}

extension ProductViewController : UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           if searchText == "" {
                     isSearching = false
                  } else {
                      isSearching = true
        
                      searchArray = productNameArray.filter({$0.lowercased().contains(searchText.lowercased())})
                        searchPictureArray = productPictureArray.filter({$0.lowercased().contains(searchText.lowercased())})

                  }
                  
        self.collectionView.reloadData()
           
       }
       
    
    
}
