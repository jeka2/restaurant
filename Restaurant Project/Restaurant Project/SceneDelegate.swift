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
        let controller = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() as! ViewController
        let coordinator = Coordinator(controller)
        controller.delegate = coordinator
        let BottleRocketNC = UINavigationController(rootViewController: BottleRocketController())
        let tabBar = UITabBarController()
        coordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        tabBar.viewControllers = [coordinator.navigationController, BottleRocketNC]
        window.rootViewController = tabBar
        // window.rootViewController = coordinator.navigationController
        self.window = window
        window.makeKeyAndVisible()
        
    }
}
func createBottleRocketNC()->UINavigationController{
    let BottleRockeVC = BottleRocketController()
    BottleRockeVC.title = "Internet"
    BottleRockeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
    return UINavigationController(rootViewController: BottleRockeVC)
}

