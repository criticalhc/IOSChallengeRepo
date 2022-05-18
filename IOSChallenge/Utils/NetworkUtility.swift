//
//  NetworkUtility.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import Foundation
import Swift


let enableCaching = true



/// Provides decoded data from a given GET API
/// - Parameters:
///   - url: url to hit
///   - session: URL session object
/// - Returns: Generic return  type
func getData<T : Codable>(_ url : URL, session : URLSessionProtocol = URLSession.shared) async -> T? {
    return await withCheckedContinuation { cont in
        let session = session.dataTask(with: url) { data, response, error in
            
            var cachedData : Data?
            
            if let error = error {
                print("Error was thrown while hitting API")
                print(error)
                if(enableCaching) {
                    print("loading data from cache")
                    cachedData = loadCachedData()
                }
            }
            if let rawData = data {
                return handleDataFromApi(rawData, cachedData, cont: cont, typeOfData : T?.self)
            }
        
            
            cont.resume(returning: nil)
            
        }
        session.resume();
    }
}


/// Get the URL of the local storage for cached planets
/// - Returns: URL
func getPlanetsUrl() -> URL {
    return getDocumentsDirectory().appendingPathComponent("planets.json")
}

/// Loads planet  data from the local cache
/// - Returns: Data from local storage
func loadCachedData() -> Data? {
    do {
        if (enableCaching) {
            let cachedData = try Data(contentsOf: getPlanetsUrl())
            return cachedData
        } else {
            return nil
        }
        
    } catch {
        print("Could not load cached Data...")
    }
    
    return nil
}


/// Helper function designed to handle data recievied from the backend API
/// - Parameters:
///   - rawData: raw data from an API response
///   - cachedData: if cached data is provided and raw data is null. the cached data will be used
///   - cont: Checked continuation used to allow async execution
///   - typeOfData: Type of data to be returned
func handleDataFromApi<T : Codable>(_ rawData: Data, _ cachedData: Data?, cont : CheckedContinuation<T, Never>, typeOfData : T.Type) {
    var decodedObject : T? = nil
    do {
        decodedObject = try JSONDecoder.init().decode(T.self, from: rawData)
        
        if let decodedObject = decodedObject {
            if(enableCaching) {
                print("Writing data to cache")
                try String(data: rawData, encoding: .utf8)?.write(to: getPlanetsUrl(), atomically: true, encoding: .utf8)
            }
        } else if let cachedData = cachedData {
            decodedObject = try JSONDecoder.init().decode(T.self, from: cachedData)
        }
        
    } catch {
        print(String(data: rawData, encoding: .utf8))
        print("Could not decode given object: \(error)")
    }
    
    if let result = decodedObject {
        cont.resume(returning: result)
        return
    } else {
        print("Could not extract data from given JSON")
        return
    }
}
