//
//  CollectionViewCell.swift
//  Restaurant Project
//
//  Created by rave on 11/2/21.
//

import UIKit
import MapKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    var favorited = false
    
    private var model : Restaurant?
    
    override func didMoveToSuperview() {
        heartImageView.image = favorited == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont(name:"Avenir Next Demi Bold",size:16)
        nameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        nameLabel.layer.zPosition = 1
        
        categoryLabel.font = UIFont(name:"Avenir Next Demi Bold",size:12)
        categoryLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        categoryLabel.layer.zPosition = 1
        
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    
    }
    
    
    func fillHeart() {
        favorited = true
    }
    
    func configure(model: Restaurant?) {
        if let model = model {
            self.model = model
            nameLabel.text = model.name
            categoryLabel.text = model.category
            
            if let imageCache = ImageCache.shared.read(imageStr: model.backgroundImageURL) {
                self.imageView.image = imageCache
            } else {
                Network.shared.fetchImage(imageUrl: model.backgroundImageURL) { image in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}
