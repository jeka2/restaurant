//
//  RestaurantViewModel.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation
import UIKit

class RestaurantViewModel {
    var restaurantInfo: RestaurantResponse? {
        didSet {
            fetchFavoriteStatuses()
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    var markedToBeChecked : [Int] = []
    func fetchRestaurantInfo(fromCache : Bool = false) {
        if fromCache {
            do {
                
                let restaurants = try DiskStorage.read()
                if let restaurants = restaurants {
                    convertIndividualModelsToResponse(restaurants)
                }
            } catch {
                print(error)
            }
        } else {
            Network.shared.fetchRestaurantInfo(url: "https://s3.amazonaws.com/br-codingexams/restaurants.json") { restaurantInfo in
                self.restaurantInfo = restaurantInfo
            }
        }
    }
    
    var numberOfRows: Int {
        self.restaurantInfo?.restaurants.count ?? 0
    }
    
    var updateUI: (() -> ())?
    var updateHeartUI: (() -> ())?
    
    func getRecordAtRow(row: Int) -> Restaurant? {
        if let restaurant = restaurantInfo?.restaurants[row] {
            return restaurant
        }
        return nil
    }
    
    private func convertIndividualModelsToResponse(_ models: [Restaurant]) {
        
        self.restaurantInfo = RestaurantResponse(restaurants: models)
    }
    
    init(fromCache : Bool = false) {
        fetchRestaurantInfo(fromCache: fromCache)
        fetchFavoriteStatuses()
    }
    
    func fetchFavoriteStatuses() {
        do {
            
            markedToBeChecked = []
            let cachedRestaurants = try DiskStorage.read()
            
            if let restaurants = self.restaurantInfo?.restaurants {
                for (i, restaurantToBeDisplayed) in restaurants.enumerated() {
                    for restaurantInCache in cachedRestaurants! {
                        if (restaurantToBeDisplayed.backgroundImageURL == restaurantInCache.backgroundImageURL)
                        {
                            markedToBeChecked.append(i)
                        }
                    }
                }
            }
            
            
            
        } catch {
            
        }
    }
    
}
