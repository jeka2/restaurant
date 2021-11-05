//
//  ViewController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit

protocol ViewControllerDelegate {
    func done(selecteRestaurant:Restaurant)
    func pushFavorites()
}
class ViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    var delegate:ViewControllerDelegate?
    var viewModel = RestaurantViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    var isLandscape = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        //  .navigationBarTitle("Todo Lists", displayMode: .inline)
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .done, target: self, action: nil)
        rightBarButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButton
        title = "Lunch Tyme"
        view.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
        self.navigationItem.backButtonTitle = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        setupVM()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true
        }
        if(UIDevice.current.orientation.isPortrait){
            isLandscape = false
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
extension ViewController:UICollectionViewDataSource
{
    
    func setupViews(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
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
        cell.configure(model: viewModel.getRecordAtRow(row: indexPath.row))
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        
        if (width > 900 && isLandscape == true)
        {
            print("width/2 = \(width/2)")
            print("Collectionview.bounds.width: \(collectionView.bounds.size.width)")
            print("width: \(width)")
            return CGSize(width:(width/2), height:180)
        }
        return CGSize(width:(width), height:180)
    }
    
}

