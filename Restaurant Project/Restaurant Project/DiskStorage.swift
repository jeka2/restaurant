//
//  DiskStorage.swift
//  Restaurant Project
//
//  Created by Folarin Williamson on 8/25/21.
//

import Foundation

// https://developer.apple.com/documentation/foundation/filemanager
enum DiskStorageError: Error {
    case missingFile
    case noData

}


struct DiskStorage {
    
    static func save(withKey key: String, value: String, using fileManager: FileManager = .default) throws {
        // use the cachesDirectory
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        
        // all urls in cacheDirectory
        let folderURLs = fileManager.urls(for: cacheDirectory, in: .userDomainMask)
        
        // check out the console below
        print("\(folderURLs)")
        
        // let's create our own file that will hold our cached data
        guard let fileURL = folderURLs.first?.appendingPathComponent(key + ".cache") else {
            throw DiskStorageError.missingFile
        }
    
        // check out console below
        print("FILE URL: \(fileURL)")
        
        // remember to convert your object to a Data (bits and bytes) type
        let data: Data = try JSONEncoder().encode(value)
        
        // write it to your new file you created above
        try data.write(to: fileURL)
    }
    
    static func read(fromKey key: String, using fileManager: FileManager = .default) throws -> String {
        
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        let folderURLs = fileManager.urls(for: cacheDirectory, in: .userDomainMask)
        
        print(folderURLs)
        
        guard let fileURL = folderURLs.first?.appendingPathComponent(key + ".cache") else {
            throw DiskStorageError.missingFile
        }
        
        print(fileURL)
                
        guard let data = fileManager.contents(atPath: fileURL.path) else {
            throw DiskStorageError.noData
        }
        
        let object = try JSONDecoder().decode(String.self, from: data)
        return object
    }
}
