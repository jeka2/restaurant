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
    func done( urlString:String) {
    
        
        func eventOccurred(with type: Event, urlStr: String, titleStr: String) {
            // print ("EVENT OCCURRED CALLED, urlStr: \(urlStr)")
            let vc = BottleRocketController()
            
//            vc.urlStr = urlStr
//             vc.coordinator = self
//            navigationController?.pushViewController(vc, animated: false)
            
        }
       
        }
        navigationController.pushViewController(vc, animated: true)
        
    }
}

