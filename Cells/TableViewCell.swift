//
//  TableViewCell.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 29.11.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    var deleteButtonClicked : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        
        deleteButtonClicked?()
    }
    
    
}
