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
    
    var models : [Restaurant]? {
        didSet {
            
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            let restaurants = try DiskStorage.read()
            if let restaurants = restaurants {
                self.models = restaurants
            }
        } catch {
            print(error)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
    }

}

extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    
}

extension FavoritesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
