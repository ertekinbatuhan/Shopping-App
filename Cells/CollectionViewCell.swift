//
//  CollectionViewCell.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 30.11.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    var buttonClicked : (() -> ())?
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        buttonClicked?()
        
    }
    
}
