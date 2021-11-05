//
//  ImageCache.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private init() {}
    
    var nsCache: NSCache<NSString, UIImage> = NSCache()
    
    func read(imageStr: String) -> UIImage? {
        let nsString = imageStr as NSString
        return nsCache.object(forKey: nsString)
    }
    
    func write(imageStr: String, image: UIImage) {
        let nsString = imageStr as NSString
        nsCache.setObject(image, forKey: nsString)
    }
}
