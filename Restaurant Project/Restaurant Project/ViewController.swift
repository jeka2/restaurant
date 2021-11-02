//
//  ViewController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit

protocol ViewControllerDelegate {
    func done(selecteRestaurant:Restaurant)
}
class ViewController: UIViewController {
    
    var delegate:ViewControllerDelegate?
    var viewModel = RestaurantViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupVM()
    }
}
extension ViewController:UICollectionViewDataSource
{
    
    func setupViews(){
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
    }
    func setupVM(){
        viewModel.updateUI =  { self.collectionView.reloadData() }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedRestaurant = viewModel.getRecordAtRow(row: indexPath.row)
       
        
        if let selectedRestaurant = selectedRestaurant {
            delegate?.done(selecteRestaurant: selectedRestaurant)
        }
        
       
    }

}
extension ViewController: UICollectionViewDelegateFlowLayout
{
    
}
