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

