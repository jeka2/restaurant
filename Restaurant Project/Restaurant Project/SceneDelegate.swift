//
//  SceneDelegate.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        let tabBar = UITabBarController()
        let controller = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() as! ViewController
        let coordinator = Coordinator(controller)
        let lunchImage = UIImage(named: "tab_lunch")
        controller.delegate = coordinator
        let tabBarBackgroundImage = UIImage(named: "cellGradientBackground")
        coordinator.navigationController.tabBarItem = UITabBarItem(title: "Lunch", image: lunchImage, tag: 0)
        tabBar.viewControllers = [coordinator.navigationController, createBottleRocketNC()]
       // imageView.contentMode = UIView.ContentMode.scaleAspectFill
        //tabBar.tabBar.backgroundImage = tabBarBackgroundImage
  
        tabBar.tabBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0
        )
        
        tabBar.tabBar.isTranslucent = false
        window.rootViewController = tabBar
        // window.rootViewController = coordinator.navigationController
        self.window = window
        window.makeKeyAndVisible()
        
    }

//func createCoordinatorNC()->UINavigationController{
//    let controller = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() as! ViewController
//    let coordinator = Coordinator(controller)
//    controller.delegate = coordinator
//    coordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//    return UINavigationController(rootViewController: coordinator.navigationController  )
//  
//}
}
func createBottleRocketNC()->UINavigationController{
    let BottleRockeVC = BottleRocketController()
    BottleRockeVC.title = "Internet"
    let internetImage = UIImage (named: "tab_internets")
    
    let tabBarItem = UITabBarItem(title: "Internet", image: internetImage, tag: 1)
    BottleRockeVC.tabBarItem = tabBarItem
    
    return UINavigationController(rootViewController: BottleRockeVC)
}

