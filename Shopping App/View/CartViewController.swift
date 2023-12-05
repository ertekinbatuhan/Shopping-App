//
//  ViewController.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 29.11.2023.
//

import UIKit
import Firebase
import FirebaseFirestore


class CartViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var productArray = [Product]()
    var productNameArray = [String]()
    var productPictureArray = [String]()
    var productIdArray = [String]()
    var searchArray = [String]()
    var searchPictureArray = [String]()
    var isSearching = false
    var cartViewModel = CartViewModel()
      
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
       // loadProducts()
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
       
        _ = cartViewModel.productNameArray.subscribe(onNext: { data in
            
            self.productNameArray = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        _ = cartViewModel.productPictureArray.subscribe(onNext: { data in
            
            self.productPictureArray = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let tabBarItems = tabBarController?.tabBar.items {
            
            let cart = tabBarItems[1]
            cart.badgeValue =  String(productNameArray.count)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if let tabBarItems = tabBarController?.tabBar.items {
            
            let cart = tabBarItems[1]
            cart.badgeValue =  String(productNameArray.count)
            
        }
        
    }
    
/*    func loadProducts() {
        
        let db = Firestore.firestore()
        db.collection("selectedProducts").addSnapshotListener{ snapshots, error in
            
            if error != nil {
                print(error?.localizedDescription)
                
            } else {
            
                self.productNameArray.removeAll()
                self.productPictureArray.removeAll()
                self.productIdArray.removeAll()
                
                for document in snapshots!.documents {
                
                    if let productName = document.get("Product Name") as?  String {
                        
                        self.productNameArray.append(productName)
                    }
                    
                    if let productPicture = document.get("Product Picture") as? String {
                
                        self.productPictureArray.append(productPicture)
                        
                    }
                    
                    if let productID = document.get("Product Id") as? String {
                    
                        self.productIdArray.append(productID)
                    }
                }
               
            }
            self.tableView.reloadData()
            
        }
    }
 */
  
}
  extension  CartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if isSearching {
                    
                    return searchArray.count
                    
                } else  {
                    return productNameArray.count
                }
    }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell" , for: indexPath) as! TableViewCell
        
        cell.productName.text = productNameArray[indexPath.row]
        cell.productImage.image = UIImage(named: productPictureArray[indexPath.row])
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.background.layer.cornerRadius = 10.0
        
        if isSearching {
            cell.productName.text = searchArray[indexPath.row]
            cell.productImage.image = UIImage(named:searchPictureArray[indexPath.row] )
            
                } else {
                    cell.productName.text = productNameArray[indexPath.row]
                    cell.productImage.image = UIImage(named: productPictureArray[indexPath.row])
                    
                }
    
        cell.deleteButtonClicked = {
            let db = Firestore.firestore()
            
            let query = db.collection("selectedProducts").whereField("Product Name", isEqualTo: self.productNameArray[indexPath.row])
            
            self.productNameArray.removeAll()
           self.productPictureArray.removeAll()
        
            query.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print((error.localizedDescription))
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.delete { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
           
        }
        
        return cell 
    }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 180.0
      }
}

extension CartViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           if searchText == "" {
                     isSearching = false
                  } else {
                      isSearching = true

                searchArray = productNameArray.filter({$0.lowercased().contains(searchText.lowercased())})
                searchPictureArray = productPictureArray.filter({$0.lowercased().contains(searchText.lowercased())})
                        
                  }
                  
        self.tableView.reloadData()
           
       }
}



  




