//
//  Coordinator.swift
//  Restaurant Project
//
//  Created by rave on 11/2/21.
//


import UIKit
//coordinator for Main ViewController
class Coordinator{
    let navigationController: UINavigationController
    init(_ rootController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootController)
    }
}

extension Coordinator: ViewControllerDelegate {
    func pushFavorites() {
        let vc = UIStoryboard(name: "FavoritesView", bundle: nil).instantiateViewController(withIdentifier: "FavoritesView") as! FavoritesViewController
        navigationController.pushViewController(vc, animated: true)
    }

    func done( selecteRestaurant:Restaurant) {
        let vc = UIStoryboard(name: "DetailView", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.setModel(model: selecteRestaurant)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}

