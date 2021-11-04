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
    
    func fetchImage(imageUrl: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                
                return
            }
            
            if let image = UIImage(data: data) {
                ImageCache.shared.write(imageStr: imageUrl, image: image)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
        }.resume()
    }
}

