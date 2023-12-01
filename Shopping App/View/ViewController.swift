//
//  ViewController.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 29.11.2023.
//

import UIKit
import Firebase
import FirebaseFirestore


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var productArray = [Product]()
    var productNameArray = [String]()
    var productPictureArray = [String]()
    var productIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        loadProducts()
        
    }
    
    func loadProducts() {
        
        let db = Firestore.firestore()
        db.collection("selectedProducts").addSnapshotListener{ snapshots, error in
    
            if error != nil {
                
                print(error?.localizedDescription)
                
            } else {
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
                self.tableView.reloadData()
            }
        }
        
    }

}

  extension  ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell" , for: indexPath) as! TableViewCell
        
        cell.productName.text = productNameArray[indexPath.row]
        cell.imageProduct.image = UIImage(named: productPictureArray[indexPath.row])
    
        cell.deleteButtonClicked = {
            let db = Firestore.firestore()
            
            let query = db.collection("selectedProducts").whereField("Product Name", isEqualTo: self.productNameArray[indexPath.row])
            
            self.productNameArray.removeAll()
            self.productPictureArray.removeAll()
            
            query.getDocuments { (querySnapshot, error) in
            
                if let error = error {
                    print("Veri çekme hatası: \(error.localizedDescription)")
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
  




