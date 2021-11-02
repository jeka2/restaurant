//
//  Network.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit

class Network {
    private init() {}
    static var shared = Network()
    
    func fetchRestaurantInfo(url: String, completion: @escaping (RestaurantResponse) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { d, r, e in
            guard let data = d else { return }
            
            do {
                let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                
                completion(response)
            } catch {
                print(error)
            }
        }.resume()
    }
}
