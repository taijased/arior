//
//  NetworkDataFetcher.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import XMLCoder


protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void)
    func fetchGenericXMLData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void)
}

class NetworkDataFetcher: DataFetcher{
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void) {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Failed  received requesting data", error)
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    
    func fetchGenericXMLData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void) {
        networking.request(urlString: urlString) { (data, error) in
            
            if let error = error {
                print("Failed  received requesting data", error)
                response(nil)
            }
            
            do {
                let decoded = try XMLDecoder().decode(T.self, from: data!)
                response(decoded)
                
            } catch let xmlError {
                print("Failed to decode XML", xmlError)
                response(nil)
            }
        }
    }
    
    
    
    
    
    
    fileprivate func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
            
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
