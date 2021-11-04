//
//  FavoritesViewController.swift
//  Restaurant Project
//
//  Created by rave on 11/4/21.
//

import UIKit

//protocol FavaritesVCDelegate {
//    func done()
//}

class FavoritesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = RestaurantViewModel(fromCache: true)
    var coordinator: ViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
    }

}

extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.bounds.size.width), height:180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FavoritesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.configure(model: viewModel.getRecordAtRow(row: indexPath.row))
        return cell
    }
    
    
}
