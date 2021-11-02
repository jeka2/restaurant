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
        // Initialization code
    }
    func configure(model: Restaurant?) {
        guard let model = model else { return }
       
        if let name = model.name
        {
            nameLabel.text = name
        }
        if let category = model.category
        {
            categoryLabel.text = category
        }
        
    }
    
    
    
}
