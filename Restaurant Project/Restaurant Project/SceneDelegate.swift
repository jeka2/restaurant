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
        let lunchImage = UIImage(named: "tab_lunch")
        controller.delegate = coordinator
        coordinator.navigationController.tabBarItem = UITabBarItem(title: "Lunch", image: lunchImage, tag: 0)
        
        let bottleRocketController = BottleRocketController()
        let bottleRocketCoordinator = BottleRocketCoordinator(bottleRocketController)
        bottleRocketController.delegate = bottleRocketCoordinator as? BottleRocketVCDelegate
        let internetImage = UIImage (named: "tab_internets")
        bottleRocketCoordinator.bottleRockeNC.tabBarItem = UITabBarItem(title: "Internet", image: internetImage, tag: 1)
        let favoritesController = FavoritesViewController()
        let favoritesCoordinator = FavoritesCoordinator(favoritesController)
        
        
        favoritesCoordinator.favoritesNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        let tabBar = UITabBarController()
        let tabBarBackgroundImage = UIImage(named: "cellGradientBackground")
        tabBar.viewControllers = [coordinator.navigationController, bottleRocketCoordinator.bottleRockeNC, favoritesCoordinator.favoritesNC]
        tabBar.tabBar.backgroundImage = tabBarBackgroundImage
        tabBar.tabBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0
        )
        tabBar.tabBar.isTranslucent = false
        window.rootViewController = tabBar
        self.window = window
        window.makeKeyAndVisible()
        
    }
}


