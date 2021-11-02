//
//  RestaurantViewModel.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation

class RestaurantViewModel {
    var restaurantInfo: RestaurantResponse? {
        didSet {
            DispatchQueue.main.async {
                
                self.updateUI?()
            }
        }
    }
    func fetchRestaurantInfo() {
        Network.shared.fetchRestaurantInfo(url: "https://s3.amazonaws.com/br-codingexams/restaurants.json") { restaurantInfo in
            self.restaurantInfo = restaurantInfo
        }
    }
    
    var numberOfRows: Int {
        self.restaurantInfo?.restaurants.count ?? 0
    }
    
    var updateUI: (() -> ())?
    
    func getRecordAtRow(row: Int) -> Restaurant? {
        if let restaurant = restaurantInfo?.restaurants[row] {
            return restaurant
        }
        return nil
    }
    
    init() {
        fetchRestaurantInfo()
    }
    
    
}
