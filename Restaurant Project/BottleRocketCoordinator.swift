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
//        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .done, target: self, action: nil)
//        rightBarButton.tintColor = .white
////        self.bottleRockeNC.navigationItem.rightBarButtonItem = rightBarButton
//        self.bottleRockeNC.title = "Lunch Tyme"
//        self.bottleRockeNC.navigationBar.titleTextAttributes =
//        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
//         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
//        self.bottleRockeNC.navigationBar.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
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
