import Foundation

enum DiskStorageError: Error {
    case missingFile
    case noData

}


struct DiskStorage {
    
    static func modify(withKey key: String, value: Restaurant?, using fileManager: FileManager = .default) throws {
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        
        let folderURLs = fileManager.urls(for: cacheDirectory, in: .userDomainMask)
        
        guard let fileURL = folderURLs.first?.appendingPathComponent(key + ".cache") else {
            throw DiskStorageError.missingFile
        }
        guard let d = fileManager.contents(atPath: fileURL.path) else {
            do {
                let data : Data = try JSONEncoder().encode([value])
                try data.write(to: fileURL)
            } catch {
                throw error
            }
            return
        }
        
        let restaurantObjects = try JSONDecoder().decode([Restaurant].self, from: d)
               
        // Below is the most clever thing I have ever written
        // The restaurant that is provided as the value is toggled between
        // being a part of the object or not
        var filteredArr = restaurantObjects.filter { $0.backgroundImageURL != value?.backgroundImageURL }
        if filteredArr.count == restaurantObjects.count {
            filteredArr.append(value!)
        }
        
        let data: Data = try JSONEncoder().encode(filteredArr)
        
        try data.write(to: fileURL)
    }
    
    static func read(fromKey key: String = "favorite-restaurants", using fileManager: FileManager = .default) throws -> [Restaurant]? {
        
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        let folderURLs = fileManager.urls(for: cacheDirectory, in: .userDomainMask)
        
        guard let fileURL = folderURLs.first?.appendingPathComponent(key + ".cache") else {
            throw DiskStorageError.missingFile
        }
                
        guard let data = fileManager.contents(atPath: fileURL.path) else {
            throw DiskStorageError.noData
        }
        
        let object = try JSONDecoder().decode([Restaurant].self, from: data)
        
        return object
    }
}
