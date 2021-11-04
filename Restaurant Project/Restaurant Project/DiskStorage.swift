import Foundation

enum DiskStorageError: Error {
    case missingFile
    case noData

}


struct DiskStorage {
    
    static func save(withKey key: String, value: Restaurant?, using fileManager: FileManager = .default) throws {
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        
        let folderURLs = fileManager.urls(for: cacheDirectory, in: .userDomainMask)
        
        print("\(folderURLs)")
        
        guard let fileURL = folderURLs.first?.appendingPathComponent(key + ".cache") else {
            throw DiskStorageError.missingFile
        }
   //
        guard let d = fileManager.contents(atPath: fileURL.path) else {
            do {
                
                let data : Data = try JSONEncoder().encode([value])
                
                try data.write(to: fileURL)
                
            } catch {
                
                throw error
            }
            
            return
        }
        
        var restaurantObjects = try JSONDecoder().decode([Restaurant].self, from: d)
        
        restaurantObjects.append(value!)
        

    //
        print("FILE URL: \(fileURL)")
        
        let data: Data = try JSONEncoder().encode(restaurantObjects)
        
        try data.write(to: fileURL)
    }
    
    static func read(fromKey key: String = "favorite-restaurants", using fileManager: FileManager = .default) throws -> [Restaurant]? {
        
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
        
        let object = try JSONDecoder().decode([Restaurant].self, from: data)
        
        return object
    }
    
    static func delete(fromKey key: String, using fileManager: FileManager = .default) {
        
    }
}
