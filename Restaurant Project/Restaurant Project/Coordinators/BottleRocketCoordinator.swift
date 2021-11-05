//
//  BottleRocketCoordinator.swift
//  Restaurant Project
//
//  Created by rave on 11/3/21.
//

import UIKit

class BottleRocketCoordinator{
    let bottleRockeNC: UINavigationController
    init(_ rootController: UIViewController) {
        self.bottleRockeNC = UINavigationController(rootViewController: rootController)
    }
   
}

extension Coordinator: BottleRocketVCDelegate {
    func done() {
//       // let vc = BottleRocketController()
//
//        navigationController.pushViewController(vc, animated: true)
//
    }
}
