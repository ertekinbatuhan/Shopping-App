//
//  TableViewCell.swift
//  Shopping App
//
//  Created by Batuhan Berk Ertekin on 29.11.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

   
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    var deleteButtonClicked : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        deleteButtonClicked?()
        
    }
}
