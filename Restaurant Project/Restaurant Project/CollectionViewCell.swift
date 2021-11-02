//
//  CollectionViewCell.swift
//  Restaurant Project
//
//  Created by rave on 11/2/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       nameLabel.font = UIFont(name:"Avenir Next Demi Bold",size:16)
        nameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        categoryLabel.font = UIFont(name:"Avenir Next Demi Bold",size:12)
         categoryLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        
    }
    
    func configure(model: Restaurant?) {
        guard let model = model else {return}
        
        nameLabel.text = model.name
        categoryLabel.text = model.category
       // imageView.image
        
        
     
        
    }
    
    
    
}
