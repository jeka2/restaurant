//
//  FavoritesCoordinator.swift
//  Restaurant Project
//
//  Created by rave on 11/2/21.
//


import UIKit
//coordinator for Main ViewController
class FavoritesCoordinator{
    let navigationController: UINavigationController
    
    init(_ rootController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootController)

        self.navigationController.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
    }
}

extension FavoritesCoordinator: FavoritesVCDelegate {
    func done( ) {
//         let vc = DetailViewController()
//        navigationController.pushViewController(vc, animated: true)
    }
}

