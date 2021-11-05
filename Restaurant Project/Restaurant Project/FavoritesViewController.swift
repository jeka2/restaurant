//
//  FavoritesViewController.swift
//  Restaurant Project
//
//  Created by rave on 11/4/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var isLandscape = Bool()
   @IBOutlet weak var favoritesCollectionView: UICollectionView!

    let viewModel = RestaurantViewModel(fromCache: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView() 
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     
        if UIDevice.current.orientation.isLandscape {
                isLandscape = true
            }
        if(UIDevice.current.orientation.isPortrait){
                isLandscape = false
        }
      //favoritesCollectionView.collectionViewLayout.invalidateLayout()
    }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = RestaurantViewModel(fromCache: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    private func setupCollectionView() {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        favoritesCollectionView!.collectionViewLayout = layout
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
        
    }
   private func setupNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
       title = "Favorites"
        view.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
    }
}

extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        if (width > 900 && isLandscape == true)
        {
            return CGSize(width:(width/2), height:180)
        }
        return CGSize(width:(width), height:180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FavoritesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel { return viewModel.numberOfRows } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if let viewModel = viewModel { cell.configure(model: viewModel.getRecordAtRow(row: indexPath.row)) }
        return cell
    }
    
    
}
