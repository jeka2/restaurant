//
//  Coordinator.swift
//  Restaurant Project
//
//  Created by rave on 11/2/21.
//


import UIKit

class Coordinator{
    let navigationController: UINavigationController
    
    init(_ rootController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootController)

        self.navigationController.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
        
      
        
    }
}

extension Coordinator: ViewControllerDelegate {
    func done( selecteRestaurant:Restaurant) {
//       // let vc = BottleRocketController()
//        
//        navigationController.pushViewController(vc, animated: true)
//        
    }
}

